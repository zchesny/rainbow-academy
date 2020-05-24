class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name 
      t.string :description
      t.integer :capacity
      t.string :location  
    end
  end
end
