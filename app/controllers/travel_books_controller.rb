class TravelBooksController < ApplicationController
  def index
    @travel_books = TravelBook.all
  end
end
