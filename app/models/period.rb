class Period < ApplicationRecord
  has_many :microposts, dependent: :nullify
end
