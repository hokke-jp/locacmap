class PagesController < ApplicationController
  def home
    @trend_all = Micropost.page(params[:page]).period_all
    # byebug
    @user = User.find(1)
    @microposts = @user.microposts
  end

  def month
    @trend_month = Micropost.page(params[:page]).period_month
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def week
    @trend_week = Micropost.page(params[:page]).period_week
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def map; end
end
