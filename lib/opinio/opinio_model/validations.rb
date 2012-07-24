module Opinio
  module OpinioModel
    module Validations

      extend ActiveSupport::Concern

      included do

        #TODO: refactor this
        if Opinio.interval_between_comments
          include Opinio::OpinioModel::Validations::IntervalMethods
          validate :validate_last_comment_time, :if => :new_record?
          cattr_accessor :comments_interval
          self.comments_interval = options.reverse_merge(:time => Opinio.interval_between_comments)[:time]
        end

        validates :body, :presence => true
        validates :commentable, :presence => true
        validates :owner, :presence => true, :associated => true

      end


      module IntervalMethods

        private

        # Checks the time of the last comment
        # made by the same owner
        def validate_last_comment_time
          last_comment = Comment.owned_by(self.owner).order('created_at DESC').last
          if last_comment
            if (Time.now - last_comment.created_at).round >= self.comments_interval
              true
            else
              errors.add(:created_at,
                         I18n.translate('opinio.messages.comment_interval',
                                        :time => self.comments_interval))
              false
            end
          else
            true
          end
        end

      end # IntervalMethods

    end # Validations
  end # OpinioModel
end # Opinio
