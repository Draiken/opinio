module Opinio
  module Schema

    def opinio(options = {})
      null    = options[:null] || false
      default = options.key?(:default) ? options[:default] : ("" if null == false)

      apply_opinio_schema :owner_id, :integer, :null => false
      apply_opinio_schema :commentable_id, :integer, :null => false
      apply_opinio_schema :commentable_type, :string, :null => false
      apply_opinio_schema :title, :string, :default => default, :null => null if options[:title]
      apply_opinio_schema :body, :text, :null => false
    end

    # Overwrite with specific modification to create your own schema.
    def apply_opinio_schema(name, type, options={})
      raise NotImplementedError
    end
    
  end
end
