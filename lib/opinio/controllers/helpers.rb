module Opinio
  module Controllers
    module Helpers

      def comments_for(object, options = {})        
        render_comments(object, options) +
        ( render_comments_form(object, options) unless options[:no_new] ).to_s
      end

      def render_comments(object, options = {})
        render( :partial => "opinio/comments/comments", :locals => {:comments => object.comments.page(1), :commentable => object} )
      end

      def render_comments_form(object, options = {})
        render( :partial => "opinio/comments/new", :locals => {:commentable => object} )
      end
    end
    
  end
  
end
