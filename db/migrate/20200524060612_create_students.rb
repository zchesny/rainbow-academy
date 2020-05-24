class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :username 
      t.string :password_digest 
    end
  end
end
