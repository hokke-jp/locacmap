class PagesController < ApplicationController
  def home
    @trend_all = Micropost.page(params[:page]).per(5).period_all
    @trend_month = Micropost.period_month
    @trend_week = Micropost.period_week
    @user = User.find(1)
    @microposts = @user.microposts
  end

  def map; end
end
