module Opinio
  module Controllers
    module Helpers

      def comments_for(object, options = {})
        render( :partial => "opinio/comments/comments", :locals => {:comments => object.comments.page(1)} ) +
        render( :partial => "opinio/comments/new", :locals => {:commentable => object} )
      end

    end
    
  end
  
end
