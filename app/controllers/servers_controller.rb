class ServersController < ApplicationController
  before_action :require_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @server = Server.new
    @server.game_name = params[:game_name]
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
    @servers = Server.all.order(created_at: :desc)
    @game_names = @servers.map { |o| o.game_name }.uniq
    @servers = @servers.where(game_name: params[:game_name]) if params[:game_name].present?
    @servers = @servers.keyword_search(params[:keyword]) if params[:keyword].present?
    @servers = @servers.page(params[:page])
  end

  def show
    @server = Server.find(params[:id])
    @server_comment = ServerComment.new
  end

  def edit
  end

  def update
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
    @user = @server.user
    @server.destroy
    redirect_to user_path(@user)
  end

  private

  def server_params
    params.require(:server).permit(:game_name, :link, :tool, :title, :body)
  end
  
  def require_logged_in
    redirect_to new_user_session_path unless current_user
  end
  
  def correct_user
    @server = current_user.servers.find_by_id(params[:id])
    redirect_to root_path unless @server
  end
end
