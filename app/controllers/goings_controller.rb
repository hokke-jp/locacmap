class GoingsController < ApplicationController
  before_action :logged_in_user
  before_action :micropost_params

  def create
    Going.create(user_id: current_user.id, micropost_id: params[:id])
    respond_to do |format|
      format.html { redirect_to microposts }
      format.js
    end
  end

  def destroy
    Going.find_by(user_id: current_user.id, micropost_id: params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to microposts }
      format.js
    end
  end

  private

  def micropost_params
    @micropost = Micropost.find(params[:id])
  end
end
