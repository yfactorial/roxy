require File.join(File.dirname(__FILE__), *%w[abstract_spec])

describe "Roxy" do

  before do
    uses_fixture(:person)
    @person = Person.new
  end

  it "should return the target when the proxy name is called" do
    @person.children.should == ['child1', 'child2']
  end
  
  it "should return the evaluated target if the target is a proc" do
    @person.parents.should == ['parent1', 'parent2']
  end
  
  it "should pass method invocations through to the target" do
    @person.children.size.should == 2
  end
  
  it "should intercept block-based proxy methods" do
    @person.children.cost.should == 200
  end
  
  it "should intercept :extend based proxy methods" do
    @person.neighbors.nearby?.should be_true
    @person.neighbors.caucasian?.should be_false
  end
end