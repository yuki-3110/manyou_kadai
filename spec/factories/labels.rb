FactoryBot.define do
  factory :label do
    name { "勉強" }
  end

  factory :label_second, class: Label do
    name { "家事" }
  end

  factory :label_third, class: Label do
    name { "遊び" }
  end
end
