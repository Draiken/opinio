module Opinio
  #autoload :Railtie, 'opinio/railtie'
  autoload :Schema, 'opinio/schema'

  module Controllers
    autoload :Helpers, 'opinio/controllers/helpers'
    autoload :InternalHelpers, 'opinio/controllers/internal_helpers'
  end



  mattr_accessor :model_name
  @@model_name = "Comment"

  mattr_accessor :use_title
  @@use_title = false

  mattr_accessor :custom_identifiers
  @@custom_identifiers = Array.new

  def self.setup
    yield self
  end

  def self.opinio_identifier(block)
    self.custom_identifiers << block
  end

  def self.check_custom_identifiers(params)
    self.custom_identifiers.each do |idf|
      ret = idf.call(params)
      return ret unless ret.nil?
    end
    nil
  end

  require File.join(File.dirname(__FILE__), 'opinio', 'railtie')
  require File.join(File.dirname(__FILE__), 'opinio', 'rails')
  require File.join(File.dirname(__FILE__), 'opinio', 'orm', 'active_record')
end
