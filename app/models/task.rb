class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum priority: {'高': 1, '中': 2, '低': 3}
  # enum status: {'進捗を選択してください': 0, '未着手': 1, '着手': 2, '完了': 3}
  enum status: {'未着手': 1, '着手': 2, '完了': 3}

  scope :search_with_both, ->(status, title){
    where(status: status).where('title LIKE ?', "%#{title}%")
  }

  scope :search_with_title, ->(title){
    where('title LIKE ?', "%#{title}%")
  }

  scope :search_with_status, ->(status){ 
    where(status: status) 
  }

end



