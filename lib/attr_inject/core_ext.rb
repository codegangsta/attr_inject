class Class
  def attr_inject(attribute, options={})
    __inject_targets << Inject::Target.new(self, attribute, options)
  end

  def __inject_targets
    @__inject_targets ||= []
  end
end

class Object
  def inject_attributes(params)
    self.class.__inject_targets.each do |target|
      target.inject params
    end
  end
end