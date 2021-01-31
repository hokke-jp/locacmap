class PagesController < ApplicationController
  def home
    @user = User.find(1)
    @microposts = @user.microposts
  end

  def map; end
end
