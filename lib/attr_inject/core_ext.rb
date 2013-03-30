class Class
  def attr_inject(attribute, params={})
    __inject_targets << Inject::Target.new(self, attribute, params)
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