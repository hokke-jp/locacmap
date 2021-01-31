class GoingsController < ApplicationController
  before_action :logged_in_user
  before_action :micropost_params

  def create
    Going.create(user_id: current_user.id, micropost_id: params[:micropost_id])
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.js
    end
  end

  def destroy
    Going.find_by(user_id: current_user.id, micropost_id: params[:micropost_id]).destroy
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.js
    end
  end

  private

  def micropost_params
    @micropost = Micropost.find(params[:micropost_id])
  end
end
