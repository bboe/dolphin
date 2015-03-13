module ApplicationHelper
  def display_user(user)
    image = user.image_url.present? ? "<img src=\"#{user.image_url}\"> " : ""
    "#{image}#{user.name}".html_safe
  end
end
