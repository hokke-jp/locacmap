class SessionsController < ApplicationController
  def new; end

  def easy
    log_in User.first
    flash[:info] = '管理ユーザーとしてログインしました'
    redirect_to root_url
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or root_url
      else
        error_message_flash
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'メールアドレスかパスワードが間違っています'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def error_message_flash
    message  = "アカウントの確認が取れませんでした。\n"
    message += 'ご登録のメールアドレスを確認してください。'
    flash[:warning] = message
  end
end
