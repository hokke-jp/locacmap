class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  belongs_to :period, optional: true
  belongs_to :prefecture, optional: true
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :latlng, presence: { message: 'を立ててください' }
  validates :prefecture_id, presence: { message: 'を選択してください' }
  validates :period_id, presence: { message: 'を選択してください' }
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 200 }
  validates :image,
            content_type: { in: %w[image/jpeg image/gif image/png], message: ' must be a valid image format' },
            size: { less_than: 5.megabytes, message: ' should be less than 5MB' }

  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [500, 240])
  end

  def self.search(search)
    return Micropost.all unless search
    Micropost.where(['title LIKE ? or content LIKE ?', "%#{search}%", "%#{search}%"])
    # Micropost.where(['title LIKE ?', "%#{search}%"])
  end

  # def self.search(search)
  #   return Micropost.all unless search
  #   split_keyword = search.split(/[[:blank:]]+/)
  #   @posts = []
  #   split_keyword.each do |keyword|
  #     next if keyword == "" 
  #     @posts += Micropost.where('title LIKE(?)', "%#{keyword}%")
  #   end 
  #   return @posts.uniq!
  # end

#   def search
#     redirect_to root_path if params[:keyword] == ""
  
#     split_keyword = params[:keyword].split(/[[:blank:]]+/)
  
#     @items = [] 
#     split_keyword.each do |keyword|
#       next if keyword == "" 
#       @items += Item.where('name LIKE(?)', "%#{keyword}%")
#     end 
#     @items.uniq! #重複した商品を削除する
#   end
end
