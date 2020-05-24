class CoursesController < ApplicationController

    get '/courses' do 
        erb :'/courses/index'
    end

    get '/courses/new' do 
        erb :'/courses/new' 
    end 

    post '/courses' do 
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

end