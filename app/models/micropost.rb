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
            content_type: { in: %w[image/jpeg image/gif image/png], message: 'のフォーマットが正しくありません' },
            size: { less_than: 5.megabytes, message: ' のサイズは5MB以下にしてください' }

  default_scope -> { order(created_at: :desc) }
  scope :search_keyword, ->(keyword) { search_user(keyword).or(search_title(keyword)).or(search_content(keyword)) }
  scope :search_user, ->(keyword) { includes(:user).where(users: { name: keyword.to_s }) }
  scope :search_title, ->(keyword) { where('title LIKE ?', "%#{keyword}%") }
  scope :search_content, ->(keyword) { where('content LIKE ?', "%#{keyword}%") }
  scope :search_prefecture, ->(prefecture_id) { where(prefecture_id: prefecture_id) if prefecture_id.present? }
  scope :search_period, ->(period_id) { where(period_id: period_id) if period_id.present? }

  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [500, 240])
  end

  def self.search(search_words, prefecture_id, period_id, sort)
    case sort
    when 'new'
      microposts = Micropost.all
    when 'going'
      microposts = Micropost.joins("LEFT OUTER JOIN goings ON microposts.id = goings.micropost_id").group('microposts.id').reorder('count(goings.id) desc')
    when 'period_asc'
      microposts = Micropost.reorder(period_id: :asc).all
    when 'period_desc'
      microposts = Micropost.reorder(period_id: :desc).all
    end

    return microposts if search_words.blank? && prefecture_id.blank? && period_id.blank?

    keywords = search_words.split(/[[:blank:]]+/)
    keywords.delete('')

    results = keywords.inject(microposts) do |relation, keyword|
      relation.search_keyword(keyword)
    end
    results.search_prefecture(prefecture_id).search_period(period_id)
  end

  def self.period_all
    Micropost.joins(:goings).group('micropost_id').reorder('count(micropost_id) desc').limit(15)
  end

  def self.period_month
    Micropost.where(created_at: 1.month.ago...Time.zone.now).joins(:goings).group('micropost_id').reorder('count(micropost_id) desc').limit(15)
  end

  def self.period_week
    Micropost.where(created_at: 1.week.ago...Time.zone.now).joins(:goings).group('micropost_id').reorder('count(micropost_id) desc').limit(15)
  end
end
