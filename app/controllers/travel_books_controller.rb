class TravelBooksController < ApplicationController
  def index
    @travel_books = TravelBook.all
  end

  def new
    @travel_book = TravelBook.new
  end
end
