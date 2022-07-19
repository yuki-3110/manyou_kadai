# User.create!(name:  "管理者",
#              email: "admin@example.jp",
#              password:  "11111111",
#              password_confirmation: "11111111",
#              admin: true)


label_names = ["勉強", "遊び", "家事"]
label_names.each do |label_name|
  Label.create!(name: label_name)
end

