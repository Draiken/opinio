class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def current_user
    u = User.new(:name => "Tester").save unless User.first
    User.first
  end

  opinio_identifier do |params|
    Post.find(params[:post_id]) if params[:post_id]
  end
end
