class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name 
      t.string :description
      t.integer :capacity
      t.string :location
      t.string :schedule_days
      t.time :start_time
      t.integer :duration
    end
  end
end
