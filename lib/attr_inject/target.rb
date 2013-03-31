module Inject
  class Target

    def initialize(klass, attribute, options={})
      @klass = klass
      @attribute = attribute

      add_accessor(attribute, klass)
    end

    def inject(params)
      validate! params
      klass.instance_variable_set "@#{attribute}", params[attribute]
    end

    private
    def add_accessor(attribute, klass)
      accessor_method = Proc.new{ 
        klass.instance_variable_get "@#{attribute}" 
      }

      klass.send(:define_method, attribute, &accessor_method)
    end

    def attribute
      @attribute
    end

    def klass
      @klass
    end

    def validate!(params)
      raise_required_error! unless params.include?(attribute)
    end

    def raise_required_error!
      raise InjectionError, ":#{attribute} is required for dependency injection."
    end

  end
end