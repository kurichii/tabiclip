class ImagesController < ApplicationController
  def ogp
    title = ogp_params[:title]
    creator = ogp_params[:creator]
    image = OgpCreator.build(title, creator).tempfile.open.read
    send_data image, type: "image/png", disposition: "inline"
  end

  private

  def ogp_params
    params.permit(:title, :creator)
  end
end
