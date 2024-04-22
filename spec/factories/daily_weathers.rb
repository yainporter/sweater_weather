FactoryBot.define do
  factory :daily_weather do
    date { "MyString" }
    sunrise { "MyString" }
    sunset { "MyString" }
    max_temp { 1.5 }
    min_temp { 1.5 }
    condition { "MyString" }
    icon { "MyString" }
  end
end
