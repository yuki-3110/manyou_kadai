class Label < ApplicationRecord
  has_many :middle, dependent: :destroy
  belongs_to :user
end
