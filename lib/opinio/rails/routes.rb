module ActionDispatch::Routing
  class Mapper
    def opinio(*args)
      route_name    = args.first || Opinio.model_name.pluralize.downcase
      options       = args.extract_options!.symbolize_keys

      get "#{ route_name }(/:page)" => "opinio/comments#index" 
    end

    def opinio_model(*args)
      options = args.extract_options!
      options[:controller] ||= 'opinio/comments'
      resources :comments, :controller => options[:controller] do
        get 'reply', :on => :member if Opinio.accept_replies
      end
    end

  end
end
