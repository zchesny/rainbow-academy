class StudentsController < ApplicationController

    get '/students/signup' do 
        erb :'/students/new' 
    end

    post '/students/signup' do 
        if params[:name] == "" || params[:password] == ""
            redirect to '/students/signup'
        elsif Student.find_by(name: params[:name]) != nil
            erb :'/students/new', locals: {message: "Sorry, a student with this name already exists. Please login or sign up with a different name."}
        else 
            user = Student.create(name: params[:name], password: params[:password])
            session[:user_id] = user.id
            session[:student] = true
            redirect to '/students/home'
        end
    end

    get '/students/login' do 
        erb :'/students/login'
    end


    post '/students/login' do 
        user = Student.find_by(name: params[:name])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          session[:student] = true 
          redirect '/students/home'
        else
          redirect '/students/signup', locals: {message: "Sorry, we couldn't find a Student matching that name and password"}
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