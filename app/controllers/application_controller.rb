require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "rainbow_secret"
  end

  get "/" do
    if !logged_in?
      erb :index
    else
      redirect '/courses'
    end
  end

  get '/logout' do
    session.destroy if logged_in?
    redirect '/'
  end

  delete '/delete' do
    if logged_in?
        current_user.delete
        session.destroy
    end
    redirect '/'
  end

  helpers do 

    def teacher? 
      !!session[:teacher]
    end

    def student?
      !!session[:student]
    end

    def logged_in?
      !!current_user
    end 

    def current_user
      if student? 
        @current_user ||= Student.find_by(id: session[:user_id]) if session[:user_id]
      elsif teacher? 
        @current_user ||= Teacher.find_by(id: session[:user_id]) if session[:user_id]
      end
    end

  end

end
