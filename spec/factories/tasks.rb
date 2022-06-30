FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    deadline  { 'test_deadline' }
    status  { 'test_status' }
    priority  { 'test_priority' }
  end
end