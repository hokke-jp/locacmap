class UsersController < ApplicationController
  before_action :logged_in_user,    only: %i[profile index edit update destroy following followers]
  before_action :correct_user,      only: %i[profile edit update]
  before_action :admin_user,        only: :destroy

  def index
    @user = current_user
    @users = User.where(activated: true).paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = current_user
    @person = User.find(params[:id])

    @microposts = @person.microposts.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = '確認メールを送信しました'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def profile
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '更新しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = '削除しました'
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # beforeアクション

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
