class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  cattr_accessor :current_user
  def current_user
    @@current_user ||= User.first || User.new(:name => "Tester")
    @@current_user.save
    @@current_user
  end

  opinio_identifier do |params|
    Post.find(params[:post_id]) if params[:post_id]
  end

  def set_current_user
    @@current_user = User.find(params[:id])
    render :nothing => true
  end
end
