module Opinio
  module Controllers
    module InternalHelpers
      extend ActiveSupport::Concern

      included do
        helper_method :resource, :resource_name
      end

      def resource
        @resource ||= custom_resouce_identifier(params) || resource_by_params 
      end

      def resource_by_params
        params[:commentable_type].constantize.find(params[:commentable_id])
      end

      def custom_resource_identifier(params)
        Opinio.identifiers(params)
        #yield(params)
      end

      def resource_name
        Opinio.name
      end
    end
  end
end
