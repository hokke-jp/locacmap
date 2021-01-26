class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[new create destroy]
  before_action :correct_user,   only: :destroy
  protect_from_forgery except: :destroy

  def index
    @microposts ||= Micropost.all
    @microposts = Micropost.paginate(page: params[:page], per_page: 10).search(params[:search])
  end

  # def index
  #   @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10) if logged_in?
  # end

  def show
    @microposts = User.find(params[:id]).microposts.paginate(page: params[:page], per_page: 10)
  end

  def new
    @micropost = current_user.microposts.build
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = '投稿しました'
      redirect_to microposts_url
    else
      render 'microposts/new'
    end
  end

  def destroy
    @micropost.destroy
    flash[:info] = '投稿を削除しました'
    redirect_back(fallback_location: root_url)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:title, :content, :image, :period_id, :prefecture_id, :latlng)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
