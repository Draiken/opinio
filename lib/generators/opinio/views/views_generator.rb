module Opinio
  module Generators
    class ViewsGenerator < Rails::Generators::Base

      source_root File.expand_path('../../../../../app/views/opinio/comments', __FILE__)

      class_option :haml, :desc => 'Generate HAML views instead of ERB.', :type => :boolean

      def copy_views
        html_names = ["_comment", "_comments", "_new", "index"]
        js_names = ["create", "destroy", "reply"]
        html_names.each do |name|
          copy_file "#{name}.html.#{view_language}", "app/views/opinio/comments/#{name}.html.#{view_language}"
        end
        js_names.each do |name|
          copy_file "#{name}.js.erb", "app/views/opinio/comments/#{name}.js.erb"
        end
      end

      def view_language
        options.haml? ? 'haml' : 'erb'
      end


    end
  end
end 
