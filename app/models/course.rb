class Course < ActiveRecord::Base 
    has_many :enrollments 
    has_many :students, through: :enrollments 

    has_many :teacher_courses 
    has_many :teachers, through: :teacher_courses 

    extend Slugifiable::ClassMethods
    include Slugifiable::InstanceMethods
    extend Sortable::ClassMethods

    def full?
        course.students.count >= course.capacity
    end 

    def students_enrolled 
    end 

    def students_waitlisted 
    end 

    def teacher_list
        self.teachers.collect{|teacher| teacher.name}.join(', ')
    end

    def scheduled_on?(day)
        !self.schedule_days.scan(day).empty?
    end 

    def time
        "#{self.start_time} - #{self.end_time}"
    end

    def sortable_time
        hour = self.military_start_time.split(":").first.to_i
        min = self.military_start_time.split(":").last.to_i
        hour = hour * 100 
        sortable_time = hour + min
    end

    def self.sort_by_time(courses)
        courses.sort_by{|c| c.sortable_time}
    end

end