# frozen_string_literal: true

module ApplicationHelper
  STOCK_IMAGE_URL = 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50'

  def display_user(user)
    path = user.image_url == STOCK_IMAGE_URL ? image_path('dolphin.png') : user.image_url
    safe_join([image_tag(path, alt: user.name), user.name])
  end
end
