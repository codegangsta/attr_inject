require "spec_helper"
require "attr_inject/injector"

describe Inject::Injector do
  let(:injector) {subject}
  let(:test_stub) {mock(:test_stub)}

  it "maps options with the map method" do
    injector.map(:foo, "foo_string")
    injector.map(:bar, 100)
    injector[:bat] = "bat"

    injector[:foo].should == "foo_string"
    injector[:bar].should == 100
    injector[:bat].should == "bat"
  end

  it "maps factories via blocks" do
    injector.factory :foo do |obj|
      "Hello #{obj.to_s}"
    end

    injector[:foo].call(:jeremy).should == "Hello jeremy"
    injector[:foo].call("jordie").should == "Hello jordie"
    injector[:foo].respond_to?(:call).should == true
  end

  it "raises an exception when a block is not passed" do
    expect { injector.factory :foo }.to raise_error(ArgumentError)
  end

  it "applies its mapped values on an object" do
    test_stub.should_receive(:inject_attributes).with(injector)
    injector.apply test_stub
  end

  it "allows the use of a parent injector" do
    result = {:foo => "foo_string", :bar => "bar_string", :bat => "bat_string"}
    test_stub.should_receive(:inject_attributes).with(result)

    injector.map(:foo, "foo_string")
    injector.map(:bar, "bar_string")

    parent = Inject::Injector.new
    injector.parent = parent
    parent.map(:bat, "bat_string")
    parent.map(:foo, "not_foo")

    injector.apply(test_stub)
  end
end
