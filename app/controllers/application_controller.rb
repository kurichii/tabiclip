class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :render404
  rescue_from ActiveRecord::RecordNotFound, with: :render404
  allow_browser versions: :modern

  before_action :authenticate_user!

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource_or_scope)
    session.delete(:after_sign_in_path) || public_travel_books_path
  end

  # 404エラーページのレンダリング
  def render404(error = nil)
    Rails.logger.error("❌#{error.message}") if error
    render template: "errors/error404", status: :not_found
  end
end
