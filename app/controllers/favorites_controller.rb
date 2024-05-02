class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    server = Server.find(params[:server_id])
    current_user.favorite(server)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    server = Server.find(params[:server_id])
    current_user.unfavorite(server)
    redirect_back(fallback_location: root_url)
  end
  
  private
  
  def require_user_logged_in
    if !current_user
      flash[:alert] = "ログインまたはサインアップが必要です."
      redirect_to new_user_session_path
    end
  end
end
