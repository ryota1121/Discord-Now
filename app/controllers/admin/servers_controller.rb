class Admin::ServersController < ApplicationController
  def index
    @servers = Server.all
  end
  
  def destroy
  end
end
