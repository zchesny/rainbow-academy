class Course < ActiveRecord::Base 
    has_many :enrollments 
    has_many :students, through: :enrollments 

    has_many :teacher_courses 
    has_many :teachers, through: :teacher_courses 

    extend Slugifiable::ClassMethods
    include Slugifiable::InstanceMethods

end