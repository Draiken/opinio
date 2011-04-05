module ActionDispatch::Routing
  class Mapper
    def opinio(*args)
      route_name = args.first
      options = args.extract_options!

      get route_name, :on => :member
    end

  end
end
