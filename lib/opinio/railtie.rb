require 'rails'

module Opinio
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'opinio' do |app|
      ActiveSupport.on_load(:active_record) do
        require File.join(File.dirname(__FILE__), 'opinio_model')
        require File.join(File.dirname(__FILE__), 'opinio_subjectum')
        ::ActiveRecord::Base.send :include, Opinio::OpinioModel
        ::ActiveRecord::Base.send :include, Opinio::OpinioSubjectum
      end
      ActiveSupport.on_load(:action_view) do
        require File.join(File.dirname(__FILE__), 'controllers', 'helpers')
        ::ActionView::Base.send :include,   Opinio::Controllers::Helpers
      end
      ActiveSupport.on_load(:action_controller) do
        require File.join(File.dirname(__FILE__), 'controllers', 'extensions')
        ::ActionController::Base.send :include,   Opinio::Controllers::Extensions
        ::ActionController::Base.send :include, Opinio::Controllers::CurrentCommenter
      end
    end
  end
end
