class HomesController < ApplicationController
  def top
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
