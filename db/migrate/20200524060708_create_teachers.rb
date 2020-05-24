class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :username 
      t.string :password_digest 
    end
  end
end
