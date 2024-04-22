class CreateDailyWeathers < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_weathers do |t|
      t.string :date
      t.string :sunrise
      t.string :sunset
      t.float :max_temp
      t.float :min_temp
      t.string :condition
      t.string :icon

      t.timestamps
    end
  end
end
