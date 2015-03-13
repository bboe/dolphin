module ApplicationHelper
  def display_user(user)
    image = "<img src=\"#{user.normed_image_url.present? ? user.normed_image_url : image_path('dolphin.png')}\"> "
    "#{image}#{user.name}".html_safe
  end
end
