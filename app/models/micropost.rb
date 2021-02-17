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
  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :image,
            content_type: { in: %w[image/jpeg image/gif image/png],
                            message: 'のフォーマットが正しくありません' },
            size: { less_than: 5.megabytes,
                    message: ' のサイズは5MB以下にしてください' }

  default_scope -> { order(created_at: :desc) }
  scope :search_keyword, lambda { |keyword|
    search_user(keyword).or(search_title(keyword)).or(search_content(keyword))
  }
  scope :search_user, lambda { |keyword|
    includes(:user).where(users: { name: keyword.to_s })
  }
  scope :search_title, lambda { |keyword|
    where('title LIKE ?', "%#{keyword}%")
  }
  scope :search_content, lambda { |keyword|
    where('content LIKE ?', "%#{keyword}%")
  }
  scope :search_prefecture, lambda { |prefecture_id|
    where(prefecture_id: prefecture_id) if prefecture_id.present?
  }
  scope :search_period, lambda { |period_id|
    where(period_id: period_id) if period_id.present?
  }

  def self.trend_by(period)
    case period
    when 'period-all'
      period_for = { created_at:
                     Time.zone.parse('20200101000000')...Time.zone.now }
    when 'period-month'
      period_for = { created_at: 1.month.ago...Time.zone.now }
    when 'period-week'
      period_for = { created_at: 1.week.ago...Time.zone.now }
    end
    Micropost.where(period_for)
             .joins(:goings)
             .group('micropost_id')
             .reorder('count(micropost_id) desc')
  end

  def self.search(search_words, prefecture_id, period_id)
    microposts = Micropost.all
    return microposts if search_words.blank? \
                      && prefecture_id.blank? \
                      && period_id.blank?

    keywords = search_words.split(/[[:blank:]]+/)
    keywords.delete('')

    results = keywords.inject(microposts) do |relation, keyword|
      relation.search_keyword(keyword)
    end
    results.search_prefecture(prefecture_id).search_period(period_id)
  end

  def self.sort_by(sort, microposts_ids)
    case sort
    when 'latest'
      sort_by = { created_at: 'desc' }
    when 'period-asc'
      sort_by = { period_id: 'asc' }
    when 'period-desc'
      sort_by = { period_id: 'desc' }
    end
    microposts = Micropost.where(id: microposts_ids).reorder(sort_by)
    [microposts, microposts.ids]
  end

  def self.sort_by_going(microposts_ids)
    microposts = Micropost.where(id: microposts_ids)
                          .includes(:gone_users)
                          .sort do |a, b|
                            b.gone_users.size <=> a.gone_users.size
                          end
    [microposts, microposts.map(&:id)]
  end
end
