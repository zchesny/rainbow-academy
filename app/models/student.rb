class Student < ActiveRecord::Base 
    has_many :enrollments 
    has_many :courses, through: :enrollments 
    has_many :teachers, through: :courses
    
    has_secure_password

    extend Slugifiable::ClassMethods
    include Slugifiable::InstanceMethods
    include Schedulable::InstanceMethods
    extend Sortable::ClassMethods

    attr_accessor :enrolled_courses, :waitlisted_courses

    @enrolled_courses = [] 
    @waitlisted_courses = [] 
end 