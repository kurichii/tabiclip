class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    @travel_book = current_user.travel_books.find(params[:travel_book_id])
  end
end
