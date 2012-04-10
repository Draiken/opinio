module Opinio
  module OpinioSubjectum
  
    def self.included(base)
      base.extend         ClassMethods
    end
  
    module ClassMethods
      def opinio_subjectum(*args)
        options = args.extract_options!

        has_many :comments,
                 :class_name => Opinio.model_name,
                 :as => :commentable,
                 :order => options.reverse_merge(:order => "created_at #{Opinio.sort_order}")[:order],
                 :dependent => :destroy


        send :include, Opinio::OpinioSubjectum::InstanceMethods
      end
    end
  
    module InstanceMethods
  
    end
  
  end
end
