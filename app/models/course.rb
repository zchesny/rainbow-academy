class Course < ActiveRecord::Base 
    has_many :enrollments 
    has_many :students, through: :enrollments 

    extend Slugifiable::ClassMethods
    include Slugifiable::InstanceMethods

end