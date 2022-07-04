class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum priority: {'優先度を選択してください': 0, '高': 1, '中': 2, '低': 3}
  enum status: {'進捗を選択してください': 0, '未着手': 1, '着手': 2, '完了': 3}
  # enum priority: [:'高', :'中', :'低']

  # enum priority: { high: 0, medium: 1, low: 2 }

  
  scope :search_with_status, ->(status){ 
    return if status.blank?
    where(status: status) 
  }
end



