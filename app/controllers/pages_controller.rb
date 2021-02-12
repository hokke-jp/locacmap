class PagesController < ApplicationController
  def home
    @pagination = params[:pagination]
    @sort = 'period-all'
    @microposts = Micropost.trend_by('period-all').page(params[:page])
    # byebug
  end

  def map
    @microposts_for_map = if params[:microposts_ids].present?
                            Micropost.page(params[:page]).where(id: params[:microposts_ids]).limit(8)
                          # byebug
                          else
                            Micropost.all.page(params[:page]).limit(8)
                            # byebug
                          end
  end
end
