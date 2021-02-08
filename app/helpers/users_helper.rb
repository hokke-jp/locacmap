module UsersHelper

  def avatar_for(user, options = { size: 40 })
    size = options[:size]
    if user.avatar.attached?
      image_tag(user.avatar.variant(gravity: :center, 
                                    resize:"#{size}x#{size}^", 
                                    crop:"#{size}x#{size}+0+0"),
                id: "user#{user.id}-avatar", alt: 'user-avatar',
                class: 'hover:opacity-50 rounded-full border border-indigo-200 shadow-md')
    else
      image_tag('default_icon.jpg', width: "#{size}px",
                id: "user#{user.id}-avatar", alt: 'user-avatar',
                class: 'hover:opacity-50 rounded-full')
    end
  end
end