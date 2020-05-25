class StudentsController < ApplicationController

    get '/students/signup' do 
        erb :'/students/new' 
    end

    post '/students/signup' do 
        if params[:username] == "" || params[:password] == ""
            redirect to '/students/signup'
        else
            user = Student.create(username: params[:username], password: params[:password])
            session[:user_id] = user.id
            session[:student] = true
            redirect to '/students/home'
        end
    end

    get '/students/login' do 
        erb :'/students/login'
    end


    post '/students/login' do 
        user = Student.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          session[:student] = true 
          redirect '/students/home'
        else
          redirect '/students/signup', locals: {message: "Sorry, we couldn't find a Student matching that username and password"}
        end
    end

    get '/students/home' do 
        # TODO: check if logged_in?
        if logged_in?
            if student? 
                erb :'/students/home'
            elsif teacher?
                redirect '/teachers/home'
            else
                redirect '/courses'
            end
        else 
            redirect '/'
        end
    end

end