require_relative '../lib/application_controller'
model_files = File.join(File.dirname(__FILE__), "../models/*.rb")
Dir[model_files].each {|file| require file }

class UsersController < ApplicationController

  def create

    @user = User.new(
      :username => params["user"]["username"],
      :discovery_radius => params["user"]["discovery_radius"]
    )

    if !@user.username.nil?
      @user.save
      redirect_to ("http://localhost:3000/users")
    else
      render :new
    end

  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    @user = User.find(Integer(params['user_id']))
    @user.first.destroy
  end

  def show
    @user = User.find(Integer(params['user_id']))
    render @user.to_json
  end

  def index
    @users = User.all
    render @users.to_json
  end

end
