class SearchesController < ApplicationController
  def search
    microposts = Micropost.search(params[:search], params[:prefecture_id], params[:period_id])
    @microposts = microposts.page(params[:page]).per(10)
    @microposts_ids = microposts.ids
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.js
    end
  end

  def sort_latest
    # byebug
    microposts = Micropost.sort_by_latest(params[:microposts_ids])
    @microposts = microposts.page(params[:page]).per(10)
    @microposts_ids = microposts.ids
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.js
    end
  end

  def sort_going
    microposts = Micropost.sort_by_going(params[:microposts_ids])
    @microposts = Kaminari.paginate_array(microposts).page(params[:page]).per(10)
    @microposts_ids = microposts.map { |micropost|
      micropost.id
    }
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.js
    end
  end

  def sort_period_asc
    microposts = Micropost.sort_by_period_asc(params[:microposts_ids])
    @microposts = microposts.page(params[:page]).per(10)
    @microposts_ids = microposts.ids
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.js
    end
  end

  def sort_period_desc
    microposts = Micropost.sort_by_period_desc(params[:microposts_ids])
    @microposts = microposts.page(params[:page]).per(10)
    @microposts_ids = microposts.ids
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.js
    end
  end
end
