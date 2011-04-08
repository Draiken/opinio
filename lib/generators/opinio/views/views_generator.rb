module Opinio
  module Generators
    class ViewsGenerator < Rails::Generators::Base

      source_root File.expand_path('../../../../../app/views', __FILE__)

      def copy_views
        directory "opinio", "app/views/opinio"
      end

    end
  end
end 
