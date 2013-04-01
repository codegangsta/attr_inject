module Inject
  class Target

    def initialize(klass, attribute, opts={})
      @klass = klass
      @attribute = attribute

      apply_options opts
      add_accessor(attribute, klass)
    end

    def apply(params, target)
      validate! params

      set_value(target, default) if !default.nil?
      set_value(target, attribute_value(params)) if params.include?(attribute)
    end

    def required?
      options[:required] && default.nil?
    end

    def default
      options[:default]
    end

    def attribute
      @attribute
    end

    def klass
      @klass
    end

    def options
      @options
    end

    private
    def add_accessor(attribute, klass)
      accessor_method = Proc.new{ 
        instance_variable_get "@#{attribute}" 
      }

      klass.send(:define_method, attribute, &accessor_method)
    end

    def attribute_value(params)
      val = params[attribute]
      val = val.call(klass) if val.respond_to?(:call)
      val
    end

    def set_value(target, val)
      target.instance_variable_set "@#{attribute}", val
    end

    def validate!(params)
      raise_required_error! if !params.include?(attribute) && required?
    end

    def raise_required_error!
      raise Inject::InjectionError, ":#{attribute} is required for dependency injection."
    end

    def apply_options(opts)
      @options = { :required => true }.merge!(opts)
    end

  end
end