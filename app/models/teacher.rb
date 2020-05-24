class Teacher < ActiveRecord::Base
    has_many :teacher_courses 
    has_many :courses, through: :teacher_courses 
    has_many :students, through: :courses

    has_secure_password
   
    extend Slugifiable::ClassMethods
    include Slugifiable::InstanceMethods

end 