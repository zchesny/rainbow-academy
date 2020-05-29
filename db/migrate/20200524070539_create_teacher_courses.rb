class CreateTeacherCourses < ActiveRecord::Migration
  def change
      create_table :teacher_courses do |t|
        t.integer :teacher_id 
        t.integer :course_id 
      end
  end
end
