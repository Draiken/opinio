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
        options = args.extract_options!

        if Opinio.use_title
          attr_accessible :title 
          validates       :title,
                          {}.merge( :length => options[:title_length] )
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

        scope :owned_by, lambda {|owner| where('owner_id = ?', owner.id) }

        send :include, Opinio::OpinioModel::InstanceMethods

        if Opinio.accept_replies
          validate :cannot_be_comment_of_a_comments_comment
          opinio_subjectum :order => 'created_at ASC'
        end

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
            errors.add(
              :created_at,
              I18n.t('opinio.comment_interval',
                     :time => self.comments_interval,
                     :default => "You must wait %{time} seconds to comment again.")
            )
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
            errors.add :base, I18n.translate('opinio.cannot_be_comment_of_comment', :default => 'Cannot reply another comment\'s reply')
          end
        end
      end

    end
  end
end
