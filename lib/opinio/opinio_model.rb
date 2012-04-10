module Opinio
  module OpinioModel

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
    
      # Adds the Opinio functionallity to the model
      # You can pass a hash of options to customize the Opinio model
      #
      # === Options
      #
      # [:belongs_to]
      #   You can specify the class that owns the comments on
      #   +config/initializers/opinio.rb+
      #   but you can also pass it explicitly here:
      #   eg. <tt>:belongs_to => "Admin"</tt>
      # [:counter_cache]
      #   Customize the counter cache here, defaults to false
      # [:body_length]
      #   You can pass a <tt>Range</tt> to determine the size of the body that will be
      #   validated
      # [:title_length]
      #   If you are using titles in your opinio model (set on the
      #   initializer) you can pass a <tt>Range</tt> so it is validated.
      def opinio(*args)
        return if self.included_modules.include?(Opinio::OpinioModel::InstanceMethods)
        options = args.extract_options!

        if Opinio.use_title
          attr_accessible :title 
          validates       :title,
                          {:presence => true}.merge( :length => options[:title_length] )
        end
        attr_accessible :body

        commentable_options = { :polymorphic => true }
        if options[:counter_cache]
          commentable_options.merge!(:counter_cache => options[:counter_cache])
        end

        belongs_to :commentable, commentable_options
        belongs_to :owner, :class_name => options.reverse_merge(:belongs_to => Opinio.owner_class_name)[:belongs_to]

        #TODO: refactor this
        if Opinio.interval_between_comments
          validate :last_comment_time, :if => :new_record?
          cattr_accessor :comments_interval
          self.comments_interval = options.reverse_merge(:time => Opinio.interval_between_comments)[:time]
        end

        extra_options = {}
        if options[:body_length]
          extra_options = { :length => options[:body_length] }
        end

        validates :body,
                  { :presence => true }.reverse_merge(extra_options)

        validates_presence_of :commentable

        validates :owner, :presence => true, :associated => true

        scope :owned_by, lambda {|owner| where('owner_id = ?', owner.id) }

        send :include, Opinio::OpinioModel::InstanceMethods

        if Opinio.accept_replies
          send :include, RepliesSupport
        end

        if Opinio.strip_html_tags_on_save
          send :include, ActionView::Helpers::SanitizeHelper
          before_save :strip_html_tags
        end

      end
    end

    module RepliesSupport
      def self.included(base)
        base.validate :cannot_be_comment_of_a_comments_comment
        base.opinio_subjectum :order => 'created_at ASC'
      end
    end

    module InstanceMethods

      private

      # Checks the time of the last comment
      # made by the same owner
      def last_comment_time
        last_comment = Comment.owned_by(self.owner).order('created_at DESC').last
        if last_comment
          if (Time.now - last_comment.created_at).round >= self.comments_interval
            true
          else
            errors.add(:created_at, I18n.translate('opinio.messages.comment_interval', :time => self.comments_interval))
            false
          end
        else
          true
        end
      end

      # Validates that you cannot comment on a comment's comment
      def cannot_be_comment_of_a_comments_comment
        if new_record? && self.commentable_type == Opinio.model_name
          if commentable.commentable_type == Opinio.model_name
            errors.add :base, I18n.t('opinio.messages,cannot_be_comment_of_comment')
          end
        end
      end

      def strip_html_tags
        self.body = strip_tags(self.body)
      end

    end
  end
end
