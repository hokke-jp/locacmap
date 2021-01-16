module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    size         = options[:size]
    gravatar_id  = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, id: 'gravatar_icon', alt: 'gravatar_icon', class: 'border-2 rounded-full shadow-md hover:opacity-50')
  end
end
