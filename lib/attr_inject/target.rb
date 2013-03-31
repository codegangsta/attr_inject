module Inject

  class Target

    def initialize(clazz, attribute, params)
      @clazz = clazz
      @attribute = attribute

      accessor_method = Proc.new{ 
        clazz.instance_variable_get "@#{attribute}" 
      }

      clazz.send(:define_method, attribute, &accessor_method)
    end

    def inject(params)
      if !params.include? @attribute
        raise InjectionError, ":#{@attribute} is required for dependency injection."
      end

      @clazz.instance_variable_set "@#{@attribute}", params[@attribute]
    end

  end

end