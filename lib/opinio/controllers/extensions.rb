module Opinio
  module Controllers
    module Extensions
      extend ActiveSupport::Concern

      module ClassMethods
        def opinio_identifier(&block)
          Opinio.opinio_identifier(block)
        end
      end
    end
  end
end
