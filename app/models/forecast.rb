class Forecast < ApplicationRecord
  has_many :current_weathers
  has_many :daily_weathers
  has_many :hourly_weathers
end
