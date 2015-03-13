module ApplicationHelper
  def display_user(user)
    "<div><img src=\"#{user.image_url}\"><br>#{user.name}</div>".html_safe
  end
end
