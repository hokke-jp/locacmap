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
end
