module Inject

  class Injector < Hash

    def map(key, val)
      self[key] = val
    end

    def factory(key, &block)
      raise ArgumentError, "Block is required for factories." if block.nil?
      self[key] = block
    end

    def apply(target)
      target.inject_attributes self
    end

  end

end