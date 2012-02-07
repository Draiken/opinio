module Opinio
  module Generators
    class InstallGenerator < Rails::Generators::NamedBase
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)


      def generate_model
        template "models/model.rb", "app/models/#{file_name}.rb"
      end

      def generate_migration
        migration_template "migrations/create_model.rb", "db/migrate/create_#{table_name}", {:assigns => {:name => name, :table_name => table_name}}
      end

      def generate_initializer
        template "initializers/opinio.erb", "config/initializers/opinio.rb"
      end

      def generate_route
        route "opinio_model"
      end

      def add_dependency_gem
        gem "kaminari"
      end

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
    end
  end
end 
