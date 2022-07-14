FactoryBot.define do
  factory :task do
    title { 'task1' }
    content { '買い物' }
    deadline  { '2022-07-22' }
    status  { 'not_yet' }
    priority  { 'high' }
  end

  factory :second_task, class: Task do
    title { 'task2' }
    content { '買い物' }
    deadline  { '2022-07-22' }
    status  { 'not_yet' }
    priority  { 'high' }
  end
end
