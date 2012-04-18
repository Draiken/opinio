module Opinio
  module Generators
    class ViewsGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      class_option :haml, :desc => 'Generate HAML views instead of ERB.', :type => :boolean

      def copy_views
        view_names = ["_comment", "_comments", "_new", "index"]
        view_names.each do |view_name|
          copy_file "#{view_language}/#{view_name}.html.#{view_language}", "app/views/opinio/comments/#{view_name}.html.#{view_language}"
        end
        directory "js", "app/views/opinio/comments"
      end

      def view_language
        options.haml? ? 'haml' : 'erb'
      end

    end
  end
end 
