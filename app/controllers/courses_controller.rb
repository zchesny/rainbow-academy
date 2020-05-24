class CoursesController < ApplicationController

    get '/courses' do 
        erb :'/courses/index'
    end

    get '/courses/new' do 
        erb :'/courses/new' 
    end 

    post '/courses' do 
        course = Course.create(params)
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

end