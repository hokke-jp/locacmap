class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  # ユーザーのログインを確認する
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'ログインしてください'
      redirect_to login_url
    end
  end

  def already_logged_in?
    if logged_in?
      flash[:info] = '既にログインしています'
      redirect_to root_url
    end
  end
end
