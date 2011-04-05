module Opinio
  module OpinioSubjectum
  
    def self.included(base)
      base.extend         ClassMethods
    end
  
    module ClassMethods
      def opinio_subjectum(*args)
        options = args.extract_options!

        has_many :comments,
                 :class_name => Opinio.name,
                 :as => :commentable,
                 :order => options.reverse_merge(:order => "created_at DESC")[:order],
                 :cache_counter => options.reverse_merge(:cache_counter => true)[:cache_counter],
                 :dependent => :destroy


        send :include, Opinio::OpinioSubjectum::InstanceMethods
      end
    end
  
    module InstanceMethods
  
    end
  
  end
end
