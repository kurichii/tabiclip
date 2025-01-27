class CheckListsController < ApplicationController
  def index
    @travel_book = current_user.travel_books.find(params[:travel_book_id])
    @check_lists = @travel_book.check_lists
  end
end
