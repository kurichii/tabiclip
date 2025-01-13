class TravelBooksController < ApplicationController
  def index
    @travel_books = TravelBook.includes(:users)
  end

  def new
    @travel_book = TravelBook.new
  end

  def create
    @travel_book = current_user.travel_books.build(travel_book_param)

    if @travel_book.save
      # 中間テーブルに関連付けを追加
      current_user.user_travel_books.create(travel_book: @travel_book)
      redirect_to travel_books_path, notice: "作成成功"
    else
      flash.now[:alert] = "作成失敗"
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
      redirect_to travel_books_path(@travel_book), notice: "編集成功"
    else
      flash.now[:alert] = "編集失敗"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def travel_book_param
    params.require(:travel_book).permit(:title, :description, :is_public, :area_id, :traveler_type_id, :start_date, :end_date)
  end
end
