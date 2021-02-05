class PagesController < ApplicationController
  def home
    @trend_all = Micropost.page(params[:page]).period_all
    # byebug
    @user = User.find(1)
    @microposts = @user.microposts
  end

  def trend_all
    @trend_all = Micropost.page(params[:page]).period_all
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def trend_month
    @trend_month = Micropost.page(params[:page]).period_month
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def trend_week
    @trend_week = Micropost.page(params[:page]).period_week
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def map
    if params[:microposts_ids].present?
      @microposts_for_map = Micropost.page(params[:page]).where(id: params[:microposts_ids]).limit(8)
      # byebug
      @microposts_for_map.reload
    else
      # @microposts_for_map = Micropost.page(params[:page]).period_week.limit(8)
      @microposts_for_map = Micropost.all.page(params[:page]).limit(8)
      # byebug
      @microposts_for_map.reload
    end
  end
end
