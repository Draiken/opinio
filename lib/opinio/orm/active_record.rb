require 'active_record/connection_adapters/abstract/schema_definitions'

module Opinio
  module Orm
    module ActiveRecord
      module Schema
        include Opinio::Schema
        # Tell how to apply schema methods.
        def apply_opinio_schema(name, type, options={})
          column name, type.to_s.downcase.to_sym, options
        end
      end
    end
  end
end

ActiveRecord::ConnectionAdapters::Table.send :include, Opinio::Orm::ActiveRecord::Schema
ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Opinio::Orm::ActiveRecord::Schema

