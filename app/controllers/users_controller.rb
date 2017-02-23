class UsersController < ApplicationController
  before_action :require_login, except: [:index, :login_user, :register_user]
  before_action :user_logged_in, only: [:dashboard, :edit, :update_user, :delete_user]

  def index # Login Registration page Post
    unless session[:id]
      @titlebar = 'Log in Or Register'
      return
    end
    redirect_to '/dashboard'
  end

  def dashboard # landing page for user
    @users = User.all
    @titlebar = "Welcome #{session[:first_name]} #{session[:last_name]}"
  end

  def edit # render landing

    @user = User.find(session[:id])
    @titlebar = "Edit #{session[:first_name]} #{session[:last_name]}"
  end

  def delete_user # delete redirect '/'

  end # No tdd

  def update_user # patch update user redirect 'edit'

  end # No TDD

  def register_user # Post for user creation
    user = User.register(params)
    if user.save
      puts '***** Passed no errors *****'
      puts 'Prams '
      user = User.find_by_email(params[:email])
      user = user.as_json
      user.each {|key, val| session[key] = val}
      puts session[:first_name]
      puts user
      redirect_to '/dashboard'
    else
      user.errors.each_entry { |key, val| flash[key] = val }
      redirect_back(fallback_location: :back)
    end
  end # no TDD

  def login_user # Post to login user
    user = User.log_in(params)

    if user[:truth]
      user.each {|key, val| session[key] = val}
      redirect_to '/dashboard'
    else
      user.each {|val| flash[:login] = val}
      redirect_back(fallback_location: :back)
    end
  end

  def logout
    session.clear
    redirect_to '/'
  end

  private
  def user_logged_in
    unless session[:id]
      redirect_to '/'
    end
  end

  def require_login
    unless session[:id]
      redirect_to '/'
    end
  end


end
