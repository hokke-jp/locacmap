class PasswordResetsController < ApplicationController
  before_action :getting_user,            only: %i[edit update]
  before_action :valid_user,              only: %i[edit update]
  before_action :check_expiration,        only: %i[edit update]
  before_action :already_authenticated?,  only: %i[edit update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:success] = 'パスワード再発行用のメールを送信しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'メールアドレスは見つかりませんでした'
      render 'new'
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = 'パスワードを変更しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # ユーザーがデータベースに存在するか確認する
  def getting_user
    @user = User.find_by(email: params[:email])
  end

  # 有効なユーザーかどうか確認する
  def valid_user
    unless @user && @user.activated? &&
           @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  # トークンが期限切れかどうか確認する
  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = 'このリンクは期限切れです'
    redirect_to new_password_reset_url
  end
end
