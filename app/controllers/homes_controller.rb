class HomesController < ApplicationController
  def top
    @servers = Server.all
    @game_names = @servers.map { |o| o.game_name }.uniq
    @ranking = @servers.group(:title).count(:title).sort_by { |k, v| v }.reverse.slice(0, 10).to_h
    @servers = @servers.where(game_name: params[:game_name]) if params[:game_name].present?
    @servers = @servers.keyword_search(params[:keyword]) if params[:keyword].present?
    @servers = @servers.page(params[:page])
  end

  def about
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
