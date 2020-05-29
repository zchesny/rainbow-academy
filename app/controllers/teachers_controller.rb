class TeachersController < ApplicationController

    get '/teachers/signup' do 
        erb :'/teachers/new' 
    end

    post '/teachers/signup' do 
        if params[:name] == "" || params[:password] == ""
            redirect to '/teachers/signup'
        elsif Teacher.find_by(name: params[:name]) != nil
            erb :'/teachers/new', locals: {message: "Sorry, a teacher with this name already exists. Please login or sign up with a different name."}
        else
            user = Teacher.create(name: params[:name], password: params[:password])
            session[:user_id] = user.id
            session[:teacher] = true
            redirect to '/teachers/home'
        end
    end

    get '/teachers/login' do 
        erb :'/teachers/login'
    end


    post '/teachers/login' do 
        user = Teacher.find_by(name: params[:name])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          session[:teacher] = true 
          redirect '/teachers/home'
        else
          erb :'/teachers/login', locals: {message: "Sorry, we couldn't find a Teacher matching that name and password"}
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