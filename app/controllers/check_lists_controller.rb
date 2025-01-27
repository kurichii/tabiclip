class CheckListsController < ApplicationController
  def index
    @travel_book = current_user.travel_books.find(params[:travel_book_id])
    @check_lists = @travel_book.check_lists
  end

  def new
    @travel_book = current_user.travel_books.find(params[:travel_book_id])
    @check_list = @travel_book.check_lists.new
  end

  def create
    @travel_book = current_user.travel_books.find(params[:travel_book_id])
    @check_list = @travel_book.check_lists.build(check_list_param)

    if @check_list.save
      redirect_to travel_book_check_lists_path(@travel_book)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def check_list_param
    params.require(:check_list).permit(:title)
  end
end
