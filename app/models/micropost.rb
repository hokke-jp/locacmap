class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  belongs_to :period, optional: true
  belongs_to :prefecture, optional: true
  has_many :goings, dependent: :destroy
  has_many :gone_users, through: :goings, source: :user

  validates :user_id, presence: true
  validates :latlng, presence: { message: 'を立ててください' }
  validates :prefecture_id, presence: { message: 'を選択してください' }
  validates :period_id, presence: { message: 'を選択してください' }
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 200 }
  validates :image,
            content_type: { in: %w[image/jpeg image/gif image/png], message: ' must be a valid image format' },
            size: { less_than: 5.megabytes, message: ' should be less than 5MB' }

  default_scope -> { order(created_at: :desc) }
  scope :search_keyword, -> (keyword) { search_title(keyword).or(search_content(keyword)) }
  scope :search_title, -> (keyword) { where('title LIKE ?', "%#{keyword}%") }
  scope :search_content, -> (keyword) { where('content LIKE ?', "%#{keyword}%") }
  scope :search_prefecture, -> (prefecture_id) { where(prefecture_id: prefecture_id) unless prefecture_id.blank? }
  scope :search_period, -> (period_id) { where(period_id: period_id) unless period_id.blank? }

  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [500, 240])
  end

  def self.search(keyword, prefecture_id, period_id)
    return Micropost.all if keyword.blank? && prefecture_id.blank? && period_id.blank?
    keywords = keyword.split(/[[:blank:]]+/)
    keywords.delete('')

    results = keywords.inject(all) do |relation, keyword|
      relation.search_keyword(keyword)
    end
    results.search_prefecture(prefecture_id).search_period(period_id)
  end

  # def self.search(search, prefecture_id, period_id)
  #   return Micropost.all unless search && prefecture_id && period_id
  #   Micropost.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
  #   Micropost.where(['title LIKE ? OR content LIKE ? AND prefecture_id = ? AND period_id = ?', "%#{search}%", "%#{search}%", prefecture_id, period_id])
  #   Micropost.where(period_id: 10)
  #   Micropost.where('prefecture_id = ? AND period_id = ?', 14, 9)
  #   Micropost.where(prefecture_id: nil)
  #   Micropost.where(user_id: [1, 2])
  # end

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
