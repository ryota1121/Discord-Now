class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @servers = Server.all
    @servers = @user.servers.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
    @servers = Server.all
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

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
