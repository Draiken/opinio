module Opinio
  module OpinioModel

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
    
      def opinio(*args)
        options = args.extract_options!

        attr_accessible :title if Opinio.use_title
        attr_accessible :body

        commentable_options = { :polymorphic => true }
        if options[:counter_cache]
          commentable_options.merge(:counter_cache => options[:counter_cache])
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
        if options[:size]
          type = ( options[:size].is_a?(Range) ? :within : :minimum )
          extra_options = { type => options[:size] }
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

      def cannot_be_comment_of_a_comments_comment
        if new_record? && self.commentable_type == Opinio.model_name
          if commentable.commentable_type == Opinio.model_name
            errors.add :base, I18n.translate('opinio.cannot_be_comment_of_comment', :default => 'Cannot reply another comment reply')
          end
        end
      end

    end
  end
end
