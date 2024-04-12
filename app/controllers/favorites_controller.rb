class FavoritesController < ApplicationController
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
end
