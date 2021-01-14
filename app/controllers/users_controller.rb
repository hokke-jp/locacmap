class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[profile index edit update destroy
                                          following followers]
  before_action :correct_user,   only: %i[edit update]

  def index
    @users = User.where(activated: true).paginate(page: params[:page],
                                                  per_page: 10)
  end

  def show
    @person = User.find(params[:id])

    @microposts = @person.microposts.paginate(page: params[:page], per_page: 10)
  end

  def profile
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

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = '更新しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.admin?  # 管理ユーザーの場合
      if current_user == @user # 自身を削除できない
        flash[:danger] = '管理ユーザーは削除できません'
      else # 他のユーザーは削除できる
        # ポートフォリオ用の'簡単ログイン'で削除できないように
        # @user.destroy
        # flash[:info] = 'アカウントを削除しました'
        flash[:info] = '現在、管理ユーザーはアカウントを削除できない設定にしてあります'
      end
    elsif current_user?(@user) # 非管理ユーザーは自分のアカウントを削除できる
      @user.destroy
      flash[:info] = 'アカウントを削除しました'
    else # 他人のアカウントは削除できない
      return
    end
    redirect_to root_url
  end

  def following
    @title = 'Following'
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
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
end
