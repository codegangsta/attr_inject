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

  it "applies options on intialize" do
    Inject::Target.any_instance.should_receive(:apply_options)
    c = Class.new
    Inject::Target.new c.class, :foo, :required => false
  end

  it "is required by default" do
    c = Class.new
    t = Inject::Target.new c.class, :foo
    t.required?.should == true
  end

  it "is can optionally not be required" do
    c = Class.new
    t = Inject::Target.new c.class, :foo, :required => false
    t.required?.should == false
  end
end