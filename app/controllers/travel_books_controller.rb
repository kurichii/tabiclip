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
      redirect_to travel_books_path, success: "作成成功"
    else
      flash.now[:danger] = "作成失敗"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def travel_book_param
    params.require(:travel_book).permit(:title, :description, :is_public, :start_date, :end_date)
  end
end
