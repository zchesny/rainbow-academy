class CoursesController < ApplicationController

    get '/courses' do 
        erb :'/courses/index'
    end

    get '/courses/new' do 
        erb :'/courses/new' 
    end 

    post '/courses' do 
        binding.pry
        course = Course.create(params)
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
        erb :'/courses/edit'
    end
   
    patch '/courses/:slug' do 
        # FIXME: prevent from updating if field is blank
        course = Course.find_by_slug(params[:slug])
        course.update(params[:course])
        redirect "/courses/#{course.slug}"
    end

    delete '/courses/:slug/delete' do
        course = Course.find_by_slug(params[:slug])
        if logged_in? && current_user.courses.include?(course)
            course.delete
        end
        redirect '/courses'
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

            end_time = [hour, min].join(":")
        end

        def get_time(time)
            hour = time.split(':').first.to_i
            min = time.split(':').last

            while hour >= 24
                hour = hour - 24
            end 
            if hour == 0 
                new_time = "#{[12, min].join(":")} AM"
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