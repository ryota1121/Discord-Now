class HomesController < ApplicationController
  def top
  end

  def about
    @servers = Server.all
    @game_names = @servers.map { |o| o.game_name }.uniq
    @game_rank = @servers.group(:game_name).count(:game_name).sort_by { |k, v| v }.reverse.slice(0, 10).to_h
    #@user_rank = @servers.group(:user_id).count(:user_id).sort_by { |k, v| v }.reverse.slice(0, 10).to_h
    @user_rank = User.joins(:servers).group(:user_id).order('count(user_id) desc')
    @servers = @servers.where(game_name: params[:game_name]) if params[:game_name].present?
    @servers = @servers.keyword_search(params[:keyword]) if params[:keyword].present?
    @servers = @servers.page(params[:page])
  end

  def guest_login
    @user = User.find_or_initialize_by(email: "guest@guest.com")
    @user.password = "xxxxxxxx"
    @user.name = "ゲストさん"
    if @user.save
      sign_in(@user)
      flash[:notice] = "ゲストログインできました"
      redirect_to root_path
    else
      flash[:alert] = "ログインに失敗しました"
      redirect_to root_path
    end
  end
end
