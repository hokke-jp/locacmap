module UsersHelper

  def avatar_for(user, options = { size: 40 })
    size = options[:size]
    if user.avatar.attached?
      image_tag(user.avatar.variant(gravity: :center, 
                                    resize:"#{size}x#{size}^", 
                                    crop:"#{size}x#{size}+0+0"),
                id: "user#{user.id}-avatar", alt: 'user-avatar',
                class: 'rounded-full shadow-md border border-indigo-200')
    else
      image_tag('default_icon.jpg', width: "#{size}px",
                id: "user#{user.id}-avatar", alt: 'user-avatar',
                class: 'rounded-full')
    end
  end
end