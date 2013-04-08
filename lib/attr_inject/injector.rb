module Inject

  class Injector < Hash

    attr_accessor :parent

    def map(key, val)
      self[key] = val
    end

    def factory(key, &block)
      raise ArgumentError, "Block is required for factories." if block.nil?
      self[key] = block
    end

    def apply(target)
      hash = parent ? parent.merge(self) : self
      target.inject_attributes hash
    end

  end

end
