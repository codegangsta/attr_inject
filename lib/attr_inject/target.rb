module Inject
  class Target

    def initialize(klass, attribute, options={})
      @klass = klass
      @attribute = attribute

      apply_options options
      add_accessor(attribute, klass)
    end

    def inject(params)
      validate! params
      klass.instance_variable_set "@#{attribute}", attribute_value(params)
    end

    def required?
      @required
    end

    def attribute_value(params)
      val = params[attribute]
      val = val.call(klass) if val.respond_to?(:call)
      val
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
      raise_required_error! unless params.include?(attribute) || !required?
    end

    def raise_required_error!
      raise InjectionError, ":#{attribute} is required for dependency injection."
    end

    def apply_options(options)
      options = { :required => true }.merge!(options)

      @required = options[:required]
    end

  end
end