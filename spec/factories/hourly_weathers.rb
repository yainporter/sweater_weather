FactoryBot.define do
  factory :hourly_weather do
    time { "MyString" }
    temperature { 1.5 }
    conditions { "MyString" }
    icon { "MyString" }
  end
end
