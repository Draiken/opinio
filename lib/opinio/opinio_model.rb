module Opinio
  module OpinioModel

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
    
      def opinio(*args)
        options = args.extract_options!
        debugger

        attr_accessible :title if self.column_names.include?("title")
        attr_accessible :body

        commentable_options = { :polymorphic => true }
        if options[:counter_cache]
          commentable_options.merge(:counter_cache => options[:counter_cache])
        end

        belongs_to :commentable, commentable_options
        belongs_to :owner, :class_name => options.merge(:belongs_to => :user)[:belongs_to]

        #TODO: refactor this
        if options[:time]
          validate :last_comment_time, :if => :new_record?
          cattr_accessor :comments_interval
          self.comments_interval = options[:time]
        end

        if options[:size]
          type = ( options[:size].is_a?(Range) ? :within : :minimum )
          extra_options = { type => options[:size] }
        end

        validates :body,
                  { :presence => true }
                  .merge(extra_options)

        validates_presence_of :commentable

        send :include, Opinio::OpinioModel::InstanceMethods

#        if options[:has_replies]
#          before_destroy :check_comments_comments 
#          validate :can_not_be_comment_of_a_comment_comment
#          opinio_subjectus :order => 'ASC'
#        end

      end
    end

    module InstanceMethods

      private

      def last_comment_time
        last_comment = self.owner.comments.last
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

    end
  end
end
