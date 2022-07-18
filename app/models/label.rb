class Label < ApplicationRecord
  has_many :middles, dependent: :destroy
  has_many :tasks, through: :middles
end
