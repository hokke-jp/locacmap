class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[new create destroy]
  before_action :correct_user,   only: :destroy

  def index
    @user = current_user
    @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10) if logged_in?
  end

  def show
    @user = current_user
    @person = User.find(params[:id])
    @microposts = @person.microposts.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = current_user
    @micropost = current_user.microposts.build if logged_in?
  end

  def create
    @user = current_user
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = '投稿しました！'
      redirect_to microposts_url
    else
      render 'microposts/new'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'Micropost deleted'
    redirect_back(fallback_location: root_url)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
