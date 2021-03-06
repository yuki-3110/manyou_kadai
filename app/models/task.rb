class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum priority: {'high': 1, 'medium': 2, 'low': 3}
  enum status: {'not_yet': 1, 'doing': 2, 'done': 3}

  scope :search_with_both, ->(status, title){
    where(status: status).where('title LIKE ?', "%#{title}%")
  }

  scope :search_with_title, ->(title){
    where('title LIKE ?', "%#{title}%")
  }

  scope :search_with_status, ->(status){ 
    where(status: status) 
  }

  paginates_per 2

end



