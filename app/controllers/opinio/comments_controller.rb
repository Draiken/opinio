class Opinio::CommentsController < ApplicationController
  include Opinio::Controllers::InternalHelpers
  include Opinio::Controllers::Replies if Opinio.accept_replies

  def index
    @comments = resource.comments.page(params[:page])
  end

  def create
    @comment = resource.comments.build(params[:comment])
    @comment.owner = send(Opinio.current_user_method)
    if @comment.save
      flash[:notice] = I18n.translate('opinio.comment.sent', :default => "Comment sent successfully.")
    else
      flash[:error]  = I18n.translate('opinio.comment.error', :default => "Error sending the comment.")
    end

    respond_to do |format|
      format.js
      format.html { redirect_to( resource ) }
    end
  end

  def destroy
    @comment = Opinio.model_name.constantize.find(params[:id])

    if can_destroy_opinio?(@comment)
      @comment.destroy
      flash[:notice] = I18n.translate('opinio.comment.destroyed', :default => "Comment removed successfully")
    else
      #flash[:error]  = I18n.translate('opinio.comment.not_permitted', :default => "Not permitted")
      logger.warn "user #{send(Opinio.current_user_method)} tried to remove a comment from another user #{@comment.owner.id}"
      render :text => "unauthorized", :status => 401 and return
    end

    respond_to do |format|
      format.js
      format.html { redirect_to( @comment.commentable ) }
    end
  end

  
end
