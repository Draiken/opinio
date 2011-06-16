module ActionDispatch::Routing
  class Mapper
    def opinio(*args)
      options       = args.extract_options!.symbolize_keys
      route_name    = options[:path_name] || Opinio.model_name.pluralize.downcase
      options[:controller] ||= 'opinio/comments'

      get "#{ route_name }(/:page)" => "#{options[:controller].to_s}#index", :as => :comments 
    end

    def opinio_model(*args)
      options = args.extract_options!
      options[:controller] ||= 'opinio/comments'
      resources :comments, options do
        get 'reply', :on => :member if Opinio.accept_replies
      end
    end

  end
end
