FactoryBot.define do
  factory :user do
    name { 'test_user_01' }
    email { 'test_user_01@test.com' }
    password { '11111111' }
    password_confirmation { '11111111' }
    admin { false }
  end

  factory :user_second, class: User do
    name { 'test_user_02' }
    email { 'test_user_02@test.com' }
    password { '22222222' }
    password_confirmation { '22222222' }
    admin { true }
  end
end

