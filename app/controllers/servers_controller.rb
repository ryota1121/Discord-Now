class ServersController < ApplicationController
  def new
    @server = Server.new
  end

  def create
    @server = Server.new(server_params)
    @server.user_id = current_user.id
    if @server.save
      redirect_to server_path(@server.id)
    else
      render :new
    end
  end

  def index
    @servers = Server.all
    @servers = Server.page(params[:page])
  end

  def show
    @server = Server.find(params[:id])
  end

  def edit
    @server = Server.find(params[:id])
  end

  def update
    server = Server.find(params[:id])
    server.update(server_params)
    redirect_to server_path(server.id)
  end

  def destroy
    server = Server.find(params[:id])
    server.destroy
    redirect_to '/servers'
  end

  private

  def server_params
    params.require(:server).permit(:game_name, :server_name, :title, :body, :image,)
  end
end
