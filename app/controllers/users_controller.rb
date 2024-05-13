class UsersController < ApplicationController
  before_action :set_user, only: [:favoris]
  
  def show
    @user = User.find(params[:id])
    @servers = @user.servers.order(created_at: :desc)
    @servers = @servers.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path
  end

  def destroy
    server = Server.find(params[:id])
    server.destroy
    redirect_to user_path
  end
  
  def favorites
    @plefix = "参加予定の"
    @user = User.find(params[:id])
    @servers = @user.favorite_servers.page(params[:page])
    @game_names = @servers.map { |o| o.game_name }.uniq
    render 'servers/index'
    #favorites = Favorite.where(user_id: @user.id).pluck(:server_id)
    #@favorite_servers = Server.find(favorites)
  end

  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
