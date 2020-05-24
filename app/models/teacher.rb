class Teacher < ActiveRecord::Base
    has_secure_password
   
    extend Slugifiable::ClassMethods
    include Slugifiable::InstanceMethods

end 