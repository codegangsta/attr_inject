require "spec_helper"
require "attr_inject/target"

describe Inject::Target do
  it "it adds an accessor method on the specified class" do
    c = Class.new
    t = Inject::Target.new(c.class, :foo)
    c.should respond_to :foo

    c2 = c.class.new
    c2.should respond_to :foo
  end
end