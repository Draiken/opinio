class Opinio::CommentsController < ApplicationController
  include Opinio::Controllers::InternalHelpers

  def index
    resource.comments.page(params[:page])
  end

  def create
    @comment = resource.comments.build(params[:comment])
    @comment.owner = current_user
    if @comment.save
      flash[:notice] = I18n.translate('opinio.comment.sent', :default => "Comment sent successfully.")
    else
      flash[:error]  = I18n.translate('opinio.comment.error', :default => "Error sending the comment.")
    end
  end
end
