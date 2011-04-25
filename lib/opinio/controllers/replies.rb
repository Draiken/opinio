module Opinio
  module Controllers
    module Replies
      extend ActiveSupport::Concern

      included do
        before_filter :check_reply, :only => [:create]
      end

      def reply
        @commentable_type = Opinio.model_name
        @commentable_id   = params[:id]
        @commentable      = Opinio.model_name.constantize.find(params[:id])
      end

      private

      def check_reply
        @reply = params[:commentable_type] == Opinio.model_name
      end
    end
  end
end
