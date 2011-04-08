module ActionDispatch::Routing
  class Mapper
    def opinio(*args)
      route_name = args.first || Opinio.model_name.pluralize.downcase
      options = args.extract_options!

      get route_name => "opinio/comments#index", :on => :member
    end

  end
end
