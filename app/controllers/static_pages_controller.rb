class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  def form; end

  def policy; end

  def terms; end

  def how_to_use; end
end
