class Class
  def attr_inject(attribute, params={})

    block = Proc.new{ instance_variable_get "@#{attribute}" }

    send(:define_method, attribute, &block)

    __attr_injects << attribute
  end

  def __attr_injects
    @__attr_injects ||= []
  end
end

class Object
  def inject_attributes(params)
    self.class.__attr_injects.each do |attribute|
      instance_variable_set "@#{attribute}", params[attribute]
    end
  end
end