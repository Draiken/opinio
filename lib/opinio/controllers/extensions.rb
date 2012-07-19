module Opinio
  module Controllers
    module Extensions

      def self.included(base)
        base.extend ClassMethods
        base.send :include, InstanceMethods

        base.class_eval do
          (class << self; self; end).instance_eval do
            define_method "#{Opinio.model_name.underscore}_destroy_conditions" do |&block|
              Opinio.set_destroy_conditions( &block )
            end
          end
        end
      end

      module ClassMethods
        def opinio_identifier(&block)
          Opinio.opinio_identifier(block)
        end
      end

      module InstanceMethods
        def can_destroy_opinio?(opinio)
          self.instance_exec(opinio, &Opinio.destroy_conditions)
        end

        def opinio_after_create_path(resource)
          resource.is_a?(Opinio.model_name.constantize) ? resource.commentable : resource
        end

        def opinio_after_destroy_path(comment)
          comment.commentable
        end
      end
    end
  end
end
