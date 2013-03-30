module Inject

  class Target

    def initialize(clazz, attribute, params)
      @clazz = clazz
      @attribute = attribute

      block = Proc.new{ clazz.instance_variable_get "@#{attribute}" }

      clazz.send(:define_method, attribute, &block)
    end

    def inject(params)
      @clazz.instance_variable_set "@#{@attribute}", params[@attribute]
    end

  end

end