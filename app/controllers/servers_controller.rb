class ServersController < ApplicationController
  def new
    @server = Server.new
  end

  def create
    @server = Server.new(server_params)
    @server.user_id = current_user.id
    if @server.save
      redirect_to user_path(@server.user.id)
    else
      render :new
    end
  end

  def index
    @servers = Server.all
    @game_names = @servers.map { |o| o.game_name }.uniq
    @servers = @servers.where(game_name: params[:game_name]) if params[:game_name].present?
    @servers = @servers.keyword_search(params[:keyword]) if params[:keyword].present?
    @servers = @servers.page(params[:page])
  end

  def show
    @server = Server.find(params[:id])
  end

  def edit
    @server = Server.find(params[:id])
  end

  def update
    @server = Server.find(params[:id])
    @user = @server.user
    if @server.update(server_params)
      flash[:notice] = "success"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "failed"
      render :edit
    end
  end

  def destroy
    @server = Server.find(params[:id])
    @user = @server.user
    @server.destroy
    redirect_to user_path(@user)
  end

  private

  def server_params
    params.require(:server).permit(:game_name, :link, :tool, :title, :body)
  end
end
