FactoryBot.define do
  factory :current_weather do
    temperature { 1.5 }
    feels_like { 1.5 }
    humidity { 1.5 }
    visibility { 1.5 }
    condition { "MyString" }
    icon { "MyString" }
  end
end
