# User.create!(name:  "管理者",
#              email: "admin@example.jp",
#              password:  "11111111",
#              password_confirmation: "11111111",
#              admin: true)


label_names = ["勉強", "遊び", "家事"]
label_names.each do |label_name|
  Label.create!(name: label_name)
end

#ラベル_データ
# sticker_names = ["打合せ", "社外秘", "共有", "告知", "重要", "機密", "出張資料", "休暇後", "出金清算", "トラブル関連"]
# sticker_names.each do |sticker_name|
#   Sticker.create!(sticker_name: sticker_name)
# end

# Label.create!(
#   name: '開発'
# )

# Label.create!(
#   name: '設計'
# )

# Label.create!(
#   name: 'テスト'
# )

# 1.times do |n|
#   name = Faker::Avatar.name
#   email = Faker::Internet.email
#   password = "password"
#   User.create!(name: name, email: email, password: password,)
# end

