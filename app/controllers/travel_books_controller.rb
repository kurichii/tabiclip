class TravelBooksController < ApplicationController
  before_action :authenticate_user!, only: %i[ index new edit update destroy ]

  def index
    @travel_books = current_user.travel_books.order(:created_at).page(params[:page])
  end

  def new
    @travel_book = TravelBook.new
  end

  def create
    @travel_book = current_user.travel_books.build(travel_book_param)
    @travel_book.creator_id = current_user.id

    if @travel_book.save
      # 中間テーブルに関連付けを追加
      current_user.user_travel_books.create(travel_book: @travel_book)
      redirect_to travel_books_path, success: t("defaults.flash_message.created", item: TravelBook.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: TravelBook.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @travel_book = TravelBook.find(params[:id])
  end

  def edit
    @travel_book = current_user.travel_books.find(params[:id])
  end

  def update
    @travel_book = current_user.travel_books.find(params[:id])

    if @travel_book.update(travel_book_param)
      redirect_to travel_books_path(@travel_book), success: t("defaults.flash_message.updated", item: TravelBook.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: TravelBook.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    travel_book = current_user.travel_books.find(params[:id])
    travel_book.destroy!
    redirect_to travel_books_path, success: t("defaults.flash_message.deleted", item: TravelBook.model_name.human)
  end

  def delete_image
    @travel_book = TravelBook.find(params[:id])
    @travel_book.remove_travel_book_image! # CarrierWaveのメソッドを使って画像を削除
    @travel_book.save
    redirect_to edit_travel_book_path(@travel_book), success: t("defaults.flash_message.deleted", item: TravelBook.model_name.human)
  end

  def public_travel_books
    @travel_books = TravelBook.where(is_public: true).includes(:users).order(:created_at).page(params[:page])
  end

  private

  def travel_book_param
    params.require(:travel_book).permit(:title, :description, :is_public, :area_id, :traveler_type_id, :start_date, :end_date, :travel_book_image, :travel_book_image_cache)
  end
end
