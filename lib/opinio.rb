module Opinio
  autoload :Schema, 'opinio/schema'

  module Controllers
    autoload :Helpers, 'opinio/controllers/helpers'
    autoload :InternalHelpers, 'opinio/controllers/internal_helpers'
    autoload :Replies, 'opinio/controllers/replies'
  end

  mattr_accessor :model_name
  @@model_name = "Comment"

  mattr_accessor :owner_class_name
  @@owner_class_name = "User"

  mattr_accessor :use_title
  @@use_title = false

  mattr_accessor :accept_replies
  @@accept_replies = false

  mattr_accessor :custom_identifiers
  @@custom_identifiers = Array.new

  mattr_accessor :interval_between_comments
  @@interval_between_comments = false

  mattr_accessor :destroy_conditions
  @@destroy_conditions = Proc.new { true }

  mattr_accessor :current_user_method
  @@current_user_method = :current_user

  mattr_accessor :strip_html_tags_on_save
  @@strip_html_tags_on_save = true

  mattr_accessor :sort_order
  @@sort_order = 'DESC'

  def self.setup
    yield self
  end

  def self.opinio_identifier(block)
    @@custom_identifiers << block
  end

  def self.set_destroy_conditions(&block)
    @@destroy_conditions = block
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
