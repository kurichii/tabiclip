class BookmarksController < ApplicationController
  def create
    travel_book = TravelBook.find(params[:travel_book_id])
    current_user.bookmark(travel_book)
    redirect_to public_travel_books_path, notice: "ブックマークしました"
  end

  def destroy
    travel_book = current_user.bookmarks.find(params[:id]).travel_book
    current_user.unbookmark(travel_book)
    redirect_to public_travel_books_path, notice: "ブックマークを解除しました", status: :see_other
  end
end
