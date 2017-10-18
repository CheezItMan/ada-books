class SessionsController < ApplicationController

  def login_form

  end

  def create
    @auth_hash = request.env['omniauth.auth']
    ap @auth_hash

    @user = User.find_by(uid: @auth_hash['uid'], provider: @auth_hash['provider'])

    if @user
      session[:user_id] = @user.id
      flash[:success] = "#{@user.name} is logged in"
    else
      @user = User.new uid: @auth_hash['uid'], provider: @auth_hash['provider'], name: @auth_hash['info']['nickname'], email: @auth_hash['info']['email']

      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "#{@user.name} is logged in"
      else
        flash[:error] = "Unable to save user!"
      end
    end
    redirect_to root_path
  end

  def login
    author = Author.find_by(name: params[:username])

    if author
      flash[:success] = "Successfully logged in as #{ author.name }"
      session[:author_id] = author.id
      redirect_to root_path
    else
      flash[:error] = "No author found by the name #{ params[:username] } "
      redirect_to root_path
    end
  end

end
