module Opinio
  module Controllers
    module Helpers

      def comments_for(object, options = {})        
        render_comments(object, options) +
        ( render_comments_form(object, options) unless options[:no_new] ).to_s
      end

      def render_comments(object, options = {})
        limit = options.delete(:limit) || Opinio.model_name.constantize.default_per_page
        page  = options.delete(:page)  || 1
        render( :partial => "opinio/comments/comments", :locals => {:comments => object.comments.page(page).limit(limit), :commentable => object, :options => options} )
      end

      def render_comments_form(object, options = {})
        render( :partial => "opinio/comments/new", :locals => {:commentable => object, :options => options} )
      end
    end
    
  end
end
