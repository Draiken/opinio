module Opinio
  module Controllers
    module InternalHelpers
      extend ActiveSupport::Concern

      included do
        helper_method :resource, :resource_name
      end

      def resource
        @resource ||= custom_resource_identifier(params) || resource_by_params 
      end

      def resource_by_params
        if params[:commentable_type]
          params[:commentable_type].constantize.find(params[:commentable_id])
        elsif params[:comment]
          params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id])
        else
          raise "Unable to determine comments holder"
        end
      end

      def custom_resource_identifier(params)
        Opinio.check_custom_identifiers(params)
      end

      def resource_name
        Opinio.model_name
      end

      def set_flash(name, message)
        flash[name] = message if Opinio.set_flash
      end
    end
  end
end
