class ServersController < ApplicationController
  def new
    @server = Server.new
  end

  def create
    server = Server.new(server_params)
    server.save
    redirect_to server_path(server.id)
  end

  def index
    @servers = Server.all
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

  private

  def server_params
    params.require(:server).permit(:game_name, :server_name, :title, :body)
  end
end
