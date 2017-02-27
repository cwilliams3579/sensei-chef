module ApplicationHelper

  def gravatar_for(user, options = { size: 120 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.chefname, class: "img-fluid rounded-circle z-depth-2")
  end

  def image_url(chef)
    user.image? ? user.image : gravatar_url(user.email.downcase)
  end
end
