class GoingsController < ApplicationController
  before_action :logged_in_user

  def create
    Going.create(user_id: current_user.id, micropost_id: params[:id])
    redirect_to microposts_url
  end

  def destroy
    Going.find_by(user_id: current_user.id, micropost_id: params[:id]).destroy
    redirect_to microposts_url
  end
end
