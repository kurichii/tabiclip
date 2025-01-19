class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # deviseコントローラーにストロングパラメータを追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_travel_book
    @travel_book = TravelBook.find(params[:id])
  end

  protected
  def configure_permitted_parameters
    # ユーザー登録時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    # ユーザー編集時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
