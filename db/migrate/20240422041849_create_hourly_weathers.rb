class CreateHourlyWeathers < ActiveRecord::Migration[7.1]
  def change
    create_table :hourly_weathers do |t|
      t.string :time
      t.float :temperature
      t.string :conditions
      t.string :icon

      t.timestamps
    end
  end
end
