class TeachersController < ApplicationController

    get '/teachers/signup' do 
        erb :'/teachers/new' 
    end

    post '/teachers/signup' do 
        if params[:username] == "" || params[:password] == ""
            redirect to '/teachers/signup'
        else
            user = Teacher.create(username: params[:username], password: params[:password])
            session[:user_id] = user.id
            session[:teacher] = true
            redirect to '/teachers/home'
        end
    end

    get '/teachers/login' do 
        erb :'/teachers/login'
    end


    post '/teachers/login' do 
        user = Teacher.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          session[:teacher] = true 
          redirect '/teachers/home'
        else
          redirect '/teachers/signup', locals: {message: "Sorry, we couldn't find a Student matching that username and password"}
        end
    end

    get '/teachers/home' do 
        # TODO: check if logged_in?
        if logged_in?
            if teacher? 
                erb :'/teachers/home'
            elsif student?
                redirect '/students/home'
            else
                redirect '/courses'
            end
        else 
            redirect '/'
        end
    end

end