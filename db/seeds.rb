User.create!(name:  "管理者",
             email: "admin@admin.com",
             password:  "11111111",
             password_confirmation: "11111111",
             admin: true)

10.times do |n|
  User.create!(
    name: "user#{n + 1}",
    email: "user#{n + 1}@user.com",
    password: "111111",
    password_confirmation: "111111",
    admin: false
  )
end

10.times do |n|
  Task.create!(
    title: "task#{n + 1}", 
    content: "content#{n + 1}",
    deadline: DateTime.now, 
    status: rand(1..3), 
    priority: rand(1..3), 
    user_id: rand(1..10)
  )
end

label_names = ["勉強", "遊び", "家事", "習い事", "美容院", "定期", "娯楽", "買い物", "ご飯", "バイト"]
label_names.each do |label_name|
  Label.create!(name: label_name)
end

