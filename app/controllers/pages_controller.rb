class PagesController < ApplicationController
  def home
    @pagination = params[:pagination]
    @sort = 'period-all'
    @microposts = Micropost.trend_by('period-all').page(params[:page])
    # byebug
  end

  def map
    @microposts = if params[:microposts_ids].present?
                    Micropost.where(id: params[:microposts_ids])
                    # byebug
                  else
                    Micropost.reorder('RAND()').limit(10).to_a
                    # Micropost.where(id: [1,2,3,4,5,6,7]).limit(8)
                    # Micropost.where(id: [8,9,10,11]).limit(8)
                    # byebug
                  end
  end
end
