class ProfilesController < ApplicationController
  before_action :owned_profile, only: [:edit, :update]
  before_action :authenticate_user!
  before_action :set_user 

  def show
    @user = set_user
    @posts = @user.posts.order('created_at DESC')
  end

  def edit
    @user = set_user
  end

  def update
    @user = set_user
    if @user.update(profile_params)
      flash[:success] = 'Your profile has been updated.'
      redirect_to profile_path(@user.user_name)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end


  private

  def profile_params  
    params.require(:user).permit(:avatar, :bio)
  end  

  def owned_profile
    @user = set_user
    unless current_user == @user
      flash[:alert] = "That profile doesn't belong to you!"
      redirect_to root_path
    end
  end

  def set_user  
    @user = User.find_by(user_name: params[:user_name])
  end

end
