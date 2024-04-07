class ServerCommentsController < ApplicationController
  
  def create
    server = Server.find(params[:server_id])
    comment = current_user.server_comments.new(server_comment_params)
    comment.server_id = server.id
    comment.save
    redirect_to server_path(server)
  end

  private

  def server_comment_params
    params.require(:server_comment).permit(:comment)
  end

  
end
