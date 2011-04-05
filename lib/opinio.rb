module Opinio
  #autoload :Railtie, 'opinio/railtie'
  autoload :Schema, 'opinio/schema'

  module Controllers
    autoload :InternalHelpers, 'opinio/controllers/internal_helpers'
  end



  mattr_accessor :name
  @@name = "Comment"

  mattr_accessor :use_title
  @@use_title = false

  def self.setup
    yield self
  end

  require File.join(File.dirname(__FILE__), 'opinio', 'railtie')
  require File.join(File.dirname(__FILE__), 'opinio', 'rails')
  require File.join(File.dirname(__FILE__), 'opinio', 'orm', 'active_record')
end
