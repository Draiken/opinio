require 'rails'

module Opinio
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'opinio' do |app|
      ActiveSupport.on_load(:active_record) do
        require File.join(File.dirname(__FILE__), 'opinio_model')
        ::ActiveRecord::Base.send :include, Opinio::OpinioModel
        print '---------------------------------------'
      end
      ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send :include,   Opinio::ActionViewExtension
      end
    end
  end
end
