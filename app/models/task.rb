class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum priority: {'選択してください': 0, '高': 1, '中': 2, '低': 3}
  # enum priority: [:'高', :'中', :'低']

  # enum priority: { high: 0, medium: 1, low: 2 }

  
  scope :search_with_priority, ->(priority){ 
    return if priority.blank?
    where(priority: priority) 
  }
end



