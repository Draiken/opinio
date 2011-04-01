module Opinio
  #autoload :Railtie, 'opinio/railtie'
  autoload :Schema, 'opinio/schema'

  require File.join(File.dirname(__FILE__), 'opinio', 'railtie')
  require File.join(File.dirname(__FILE__), 'opinio', 'orm', 'active_record')
end
