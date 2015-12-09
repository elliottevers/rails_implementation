require_relative '../lib/controller_base'
model_files = File.join(File.dirname(__FILE__), "../models/*.rb")
Dir[model_files].each {|file| require file }

class UsersController < ControllerBase

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

  def show
    @user = User.find(Integer(params['user_id']))
    render_content(@user.to_json, "application/json")
  end

  def index
    @users = User.all
    render_content(@users.to_json, "application/json")
  end

end
