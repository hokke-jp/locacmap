class SearchesController < ApplicationController
  def search
    @pagination = params[:pagination]
    @sort = 'latest'
    microposts = Micropost.search(params[:search],
                                  params[:prefecture_id],
                                  params[:period_id])
    @microposts = microposts.page(params[:page])
    @microposts_ids = microposts.ids
    respond_to do |format|
      format.html { render 'microposts/index' }
      format.js
    end
  end

  def sort
    @pagination = params[:pagination]
    @sort = params[:sort]
    case @sort
    when 'period-all', 'period-month', 'period-week'
      @microposts = Micropost.trend_by(@sort).page(params[:page])
    when 'going'
      microposts, @microposts_ids = Micropost.sort_by_going(params[:microposts_ids])
      @microposts = Kaminari.paginate_array(microposts).page(params[:page])
    else
      microposts, @microposts_ids = Micropost.sort_by(@sort, params[:microposts_ids])
      @microposts = microposts.page(params[:page])
    end
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.js
    end
  end
end
