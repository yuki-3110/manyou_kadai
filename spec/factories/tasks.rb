FactoryBot.define do
  factory :task do
    title { 'test_title1' }
    content { 'test_content1' }
    deadline  { 'test_deadline1' }
    status  { 'test_status1' }
    priority  { 'test_priority1' }
  end

  factory :second_task, class: Task do
    title { 'test_title2' }
    content { 'test_content2' }
    deadline  { 'test_deadline2' }
    status  { 'test_status2' }
    priority  { 'test_priority2' }
  end

end