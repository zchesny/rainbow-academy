class CoursesController < ApplicationController

    get '/courses' do 
        erb :'/courses/index'
    end

    get '/courses/new' do 
        erb :'/courses/new' 
    end 

    post '/courses' do 
        course = Course.create(params)
        course.update(end_time: get_time(add_time(course.military_start_time, course.duration)), start_time: get_time(course.military_start_time), schedule_days: params[:schedule_days].join('/'))
        current_user.courses << course
        redirect "/courses/#{course.slug}"
    end 

    get '/courses/:slug' do 
        @course = Course.find_by_slug(params[:slug])
        erb :'/courses/show'
    end

    post '/courses/enroll' do 
        current_user.course_ids = params[:course_ids]
        redirect '/students/home'
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
        # FIXME: prevent from updating if field is blank
        course = Course.find_by_slug(params[:slug])
        course.update(name: params[:course][:name]) if params[:course][:name] != ""
        course.update(description: params[:course][:description]) if params[:course][:description] != ""
        course.update(capacity: params[:course][:capacity]) if params[:course][:capacity] != ""
        course.update(location: params[:course][:location]) if params[:course][:location] != ""
        course.update(military_start_time: params[:course][:military_start_time]) if params[:course][:military_start_time] != ""
        course.update(start_time: get_time(course.military_start_time))
        course.update(end_time: get_time(add_time(course.start_time, course.duration)))
        course.update(schedule_days: params[:course][:schedule_days].join('/'))
        redirect "/courses/#{course.slug}"
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
        @course.update(student_ids: params[:student_ids])
        redirect "/courses/#{@course.slug}"
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