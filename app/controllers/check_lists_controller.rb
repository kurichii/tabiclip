class CheckListsController < ApplicationController
  before_action :set_travel_book, only: %i[ index new create ]
  before_action :set_check_list, only: %i[ show edit update destroy ]

  def index
    @check_lists = @travel_book.check_lists
  end

  def new
    @check_list = @travel_book.check_lists.new
  end

  def create
    @check_list = @travel_book.check_lists.build(check_list_param)

    if @check_list.save
      redirect_to travel_book_check_lists_path(@travel_book), success: t("defaults.flash_message.created", item: CheckList.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: CheckList.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @list_items = @check_list.list_items.order(created_at: :asc)
  end


  def edit; end

  def update
    if @check_list.update(check_list_param)
      redirect_to check_list_path(@check_list), success: t("defaults.flash_message.updated", item: CheckList.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: CheckList.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @check_list.destroy!
    redirect_to travel_book_check_lists_path(@travel_book), success: t("defaults.flash_message.deleted", item: CheckList.model_name.human)
  end

  private

  def set_travel_book
    @travel_book = current_user.travel_books.find(params[:travel_book_id])
  end

  def set_check_list
    @check_list = CheckList.find(params[:id])
    @travel_book = @check_list.travel_book
  end

  def check_list_param
    params.require(:check_list).permit(:title)
  end
end
