module Opinio
  module Controllers
    module Extensions
      extend ActiveSupport::Concern

      included do
        define_method "#{Opinio.model_name.underscore}_destroy_conditions" do |&block|
          Opinio.set_destroy_conditions( &block )
        end
      end

      module ClassMethods
        def opinio_identifier(&block)
          Opinio.opinio_identifier(block)
        end
      end
    end
  end
end
