module MicropostsHelper
  # def image_for(micropost, options = { size: 100 })
  def image_for(micropost)
    # size = options[:size]
    if micropost.image.attached?
      image_tag(micropost.image, class: 'w-full h-40 md:w-40 object-cover')
      # image_tag(micropost.image.variant(gravity: :center,
      #                                   resize:"160x120^",
      #                                   crop:"160x120+0+0"),
      #           id: "micropost#{micropost.id}-image", alt: 'micropost-image',
      #           class: '')
    else
      image_tag('no_image.png', class: 'w-full h-40 md:w-40 object-cover')
      # image_tag('no_image.png', :size => '160x120')
    end
  end
end
