class UsersController < ApplicationController
  before_action :logged_in_user,          only: %i[edit update destroy]
  before_action :correct_user,            only: %i[edit update]
  before_action :already_authenticated?,  only: %i[new create]
  protect_from_forgery except: :destroy

  def show
    @user = User.find(params[:id])
  end

  def related_info
    @sort = 'nil'
    @pagination = params[:pagination]
    @info = params[:info]
    @user = User.find(params[:id])
    @feed_items = @user.feed.page(params[:page])
    case params[:info]
    when 'posted'
      @microposts = Micropost.where(user_id: @user.id).page(params[:page])
    when 'checked'
      @microposts = @user.gone_microposts.page(params[:page])
    when 'favorite'
      @users = @user.following
      # byebug
    end
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:success] = '確認メールを送信しました'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = '更新しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def update_avatar
    # byebug
    @user = User.find(params[:id])
    @user.avatar.attach(params[:user][:avatar])
    respond_to do |format|
      format.html { redirect_to edit_user_path(@user) }
      format.js
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.admin?
      if current_user == @user
        flash[:danger] = '管理ユーザーは削除できません'
      else
        @user.destroy
        flash[:danger] = 'アカウントを削除しました'
      end
    elsif current_user?(@user)
      @user.destroy
      flash[:danger] = 'アカウントを削除しました'
    end
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :avatar)
  end

  # beforeアクション
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
