class CoursesController < ApplicationController

    get '/courses' do 
        erb :'/courses/index'
    end

    get '/courses/enroll' do 
        if logged_in? && student? 
            erb :'/courses/enroll'
        else 
            redirect '/courses'
        end 
    end

    get '/courses/new' do 
        erb :'/courses/new' 
    end 

    post '/courses' do 
        if !Course.valid_name?(params[:name])
            erb :'/courses/new', locals: {message: "Please enter a valid name using letters and numbers."}
        elsif Course.find_by(name: params[:name]) != nil
            erb :'/courses/new', locals: {message: "Sorry, a course with this name already exists. Please use a different name or edit the existing course."}
        elsif params[:capacity].to_i < 1 || params[:capacity].to_i > 9999
            erb :'/courses/new', locals: {message: "Please enter a course capacity between 1-9999."}
        else
            course = Course.create(params)
            course.update(end_time: get_time(add_time(course.military_start_time, course.duration)), start_time: get_time(course.military_start_time), schedule_days: params[:schedule_days].join('/'))
            current_user.courses << course
            redirect "/courses/#{course.slug}"
        end
    end 

    get '/courses/:slug' do 
        if logged_in?
            @course = Course.find_by_slug(params[:slug])
            erb :'/courses/show'
        else 
            redirect '/courses'
        end
    end

    post '/courses/enroll' do 
        # check if course is full 
        # params[:course_ids].each do |id|
        #     if course.full?
        #         current_user.waitlisted_courses < Course.find_by(id: id)
        #     else 
        #         current_user.enrolled_courses < Course.find_by(id: id) 
        #     end 
        # end
        course_ids = [] 
        course_names = [] 
        params[:course_ids].each do |id|
            course = Course.find_by(id: id)
            if course.full? 
                course_names << course.name
            else
                course_ids << id 
            end 
        end
        current_user.course_ids = course_ids
        if course_names.length > 0 
            erb :'/students/home', locals: {message: "Sorry, you were unable to enroll in the following courses because they were at maximum capacity: #{course_names.join(', ')}"}
        else 
            redirect '/students/home'
        end 
    end

    get '/courses/:slug/edit' do 
        @course = Course.find_by_slug(params[:slug])
        if logged_in? && teacher? && current_user.courses.include?(@course)
            erb :'/courses/edit'
        else 
            redirect "/courses/#{@course.slug}"
        end
    end
   
    patch '/courses/:slug' do 
        # check for valid name 
        @course = Course.find_by_slug(params[:slug])
        if  params[:course][:name] != ""
            if !Course.valid_name?(params[:course][:name])
                erb :'/courses/edit', locals: {message: "Please enter a valid name using letters and numbers."}
            elsif Course.find_by(name: params[:course][:name]) != nil && @course.name != params[:course][:name]
                erb :'/courses/edit', locals: {message: "Sorry, another course with this name already exists. Please use a different name or edit the existing course."}
            else 
                @course.update(name: params[:course][:name])
            end
        end 
        
        # check for valid capacity
        if params[:course][:capacity] != ""
            if params[:course][:capacity].to_i < 1 || params[:course][:capacity].to_i > 9999
                erb :'/courses/edit', locals: {message: "Please enter a course capcity between 1-9999."}
            else  
                @course.update(capacity: params[:course][:capacity])
            end
        end  

        # prevent from updating if field is blank
        @course.update(description: params[:course][:description]) if params[:course][:description] != ""
        @course.update(location: params[:course][:location]) if params[:course][:location] != ""
        @course.update(military_start_time: params[:course][:military_start_time]) if params[:course][:military_start_time] != ""
        @course.update(start_time: get_time(@course.military_start_time))
        @course.update(end_time: get_time(add_time(@course.start_time, @course.duration)))
        @course.update(schedule_days: params[:course][:schedule_days].join('/'))
        redirect "/courses/#{@course.slug}"
    end

    delete '/courses/:slug/delete' do
        course = Course.find_by_slug(params[:slug])
        if logged_in? && teacher? && current_user.courses.include?(course)
            course.delete
        end
        redirect '/courses'
    end

    # add or remove students 
    get '/courses/:slug/enrollment' do 
        @course = Course.find_by_slug(params[:slug])
        if logged_in? && teacher? && current_user.courses.include?(@course)
            erb :'/courses/enrollment'
        else  
            redirect "/courses/#{course.slug}"
        end
    end

    post '/courses/:slug/enrollment' do 
        @course = Course.find_by_slug(params[:slug])
        student_ids = [] 
        student_count = 0 
        student_names = [] 
        params[:student_ids].each do |id|
            student = Student.find_by(id: id)
            if student_count < @course.capacity
                student_ids << id 
                student_count += 1
            else 
                student_names << student.name 
            end 
        end 
        @course.update(student_ids: student_ids)
        if student_names.length > 0 
            erb :'/courses/show', locals: {message: "Sorry, the following students were unable to enroll because the course was at maximum capacity: #{student_names.join(', ')}"}
        else 
            redirect "/courses/#{@course.slug}"
        end 
    end

    # add or remove teachers 
    get '/courses/:slug/teachers' do 
        @course = Course.find_by_slug(params[:slug])
        if logged_in? && teacher? && current_user.courses.include?(@course)
            erb :'/courses/teachers'
        else  
            redirect "/courses/#{course.slug}"
        end
    end

    post '/courses/:slug/teachers' do 
        @course = Course.find_by_slug(params[:slug])
        @course.update(teacher_ids: params[:teacher_ids])
        redirect "/courses/#{@course.slug}"
    end

    helpers do 
        def add_time(start_time, duration)
            hour = start_time.split(':').first.to_i
            min = start_time.split(':').last.to_i
            dur = duration.to_i

            min = min + dur
            while min >= 60
                hour = hour + 1 
                min = min - 60 
            end 

            min = min.to_s
            if min.length == 1 
                min = [0, min].join
            end

            end_time = [hour, min].join(":")
        end

        def get_time(time)
            hour = time.split(':').first.to_i
            min = time.split(':').last
            if min.length == 1 
                min = [0, min].join
            end

            while hour >= 24
                hour = hour - 24
            end 
            if hour == 0 
                hour = 12
                new_time = "#{[hour, min].join(":")} AM"
            elsif hour < 12
                new_time = "#{[hour, min].join(":")} AM"
            elsif hour == 12 
                new_time = "#{[hour, min].join(":")} PM"
            else 
                hour = hour - 12 
                new_time = "#{[hour, min].join(":")} PM"
            end
        end
    end
    

end