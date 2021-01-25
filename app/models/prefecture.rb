class Prefecture < ApplicationRecord
  has_many :microposts, dependent: :nullify
end
