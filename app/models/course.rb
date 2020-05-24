class Course < ActiveRecord::Base 
    has_many :students 
    has_many :students, through: :enrollments 

    extend Slugifiable::ClassMethods
    include Slugifiable::InstanceMethods

end