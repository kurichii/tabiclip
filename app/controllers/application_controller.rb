class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  add_flash_types :success, :error

  def set_travel_book
    @travel_book = TravelBook.find(params[:id])
  end
end
