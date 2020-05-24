class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name 
      t.string :description
      t.integer :capacity
      t.string :location
      t.string :schedule_days
      t.string :start_time
      t.integer :duration
      t.string :end_time
    end
  end
end
