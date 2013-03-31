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

  it "looks up the attribute with find_attribute" do
    c = Class.new
    t = Inject::Target.new c.class, :foo

    params = {:foo => "foobar"}
    t.should_receive(:attribute_value).with(params)
    t.inject params
  end

  it "calls a factory proc if the attribute value is a block" do
    c = Class.new
    t = Inject::Target.new c.class, :foo

    params = {:foo => Proc.new{ |obj| "hello #{obj.to_s}"}}
    t.inject params

    c.foo.should == "hello Class"
  end

  it "can have default values" do
    c = Class.new
    t = Inject::Target.new c.class, :foo, :default => "hello world"

    params = {}
    t.inject params

    c.foo.should == "hello world"
  end
end