class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource_or_scope)
    session.delete(:after_sign_in_path) || public_travel_books_path
  end

  def set_travel_book
    @travel_book = TravelBook.find(params[:id])
  end
end
