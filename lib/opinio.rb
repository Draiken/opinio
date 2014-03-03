module Opinio
  require 'opinio/schema'

  module Controllers
    require 'opinio/controllers/helpers'
    require 'opinio/controllers/current_commenter'
    require 'opinio/controllers/internal_helpers'
    require 'opinio/controllers/replies'
  end

  require 'opinio/railtie'
  require 'opinio/rails'
  require 'opinio/orm/active_record'

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
  @@destroy_conditions = Proc.new { false }

  mattr_accessor :current_user_method
  @@current_user_method = :current_user

  mattr_accessor :strip_html_tags_on_save
  @@strip_html_tags_on_save = true

  mattr_accessor :sort_order
  @@sort_order = 'DESC'

  mattr_accessor :set_flash
  @@set_flash = true

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
    self.custom_identifiers.each do |identifier|
      identified = identifier.call(params)
      return identified unless identified.nil?
    end
    nil
  end
end
