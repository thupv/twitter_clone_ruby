class UsersController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :set_user, only: [:follow, :unfollow]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_url, notice: 'Signed up'
    else
      render :new
    end
  end

  # TODO follow and unfollow should be done by ajax.
  def follow
    current_user.follow(@user)
    redirect_to users_url, notice: "Following #{@user.email}"
  end

  def unfollow
    current_user.unfollow(@user)
    redirect_to users_url, notice: "Unfollowed #{@user.email}"
  end

  private
    def user_params
      params.require(:user).permit(:email, :screen_name, :password)
    end

    def set_user
      @user = User.find(params[:user_id])
    end
end
