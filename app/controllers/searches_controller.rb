class SearchesController < ApplicationController
  def search
    @microposts = Micropost.page(params[:page]).per(10).search(params[:search], params[:prefecture_id], params[:period_id])
    # @microposts_ids = @microposts.ids
    @microposts_ids = Micropost.search(params[:search], params[:prefecture_id], params[:period_id]).ids
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.js
    end
  end

  def sort_latest
    # byebug
    @microposts = Micropost.page(params[:page]).per(10).sort_by_latest(params[:microposts_ids])
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.js
    end
  end

  def sort_going
    @microposts = Micropost.sort_by_going(params[:microposts_ids])
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.js
    end
  end

  def sort_period_asc
    @microposts = Micropost.page(params[:page]).per(10).sort_by_period_asc(params[:microposts_ids])
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.js
    end
  end

  def sort_period_desc
    @microposts = Micropost.page(params[:page]).per(10).sort_by_period_desc(params[:microposts_ids])
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.js
    end
  end
end
