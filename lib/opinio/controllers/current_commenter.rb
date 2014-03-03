module Opinio
  module Controllers
    module CurrentCommenter
      extend ActiveSupport::Concern

      def current_commenter
        send Opinio.current_user_method
      end

      included do
        helper_method :current_commenter
      end
    end
  end
end
