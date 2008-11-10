require File.join(File.dirname(__FILE__), *%w[abstract_spec])

describe "Whole family example" do

  before do
    uses_fixture(:family)
    @ryan = Person.new('Ryan', 'Daigle')
    @ryan_parents = [Person.new('Dad', 'Daigle'), Person.new('Mom', 'Daigle')]
    @ryan.parents = @ryan_parents
    @ryan_children = [Person.new('Child1', 'Daigle'), Person.new('Child2', 'Daigle')]
    @ryan.children = @ryan_children
  end
  
  it "should know a person's parents (proxy should not overwrite target method)" do
    @ryan.parents.should == @ryan_parents
  end
  
  it "should know if a person's parents are divorced" do
    @ryan.parents.divorced?.should be_false
  end
  
  it "should know how to print out parents names' to a string when not divorced" do
    @ryan.parents.to_s.should == "Mr. and Mrs. Daigle"
  end
  
  it "should know how to get a person's step-children" do
    @ryan.children.step.should be_empty
  end
end

describe "Divorced family example" do

  before do
    uses_fixture(:family)
    @ryan = Person.new('Ryan', 'Daigle')
    @ryan_parents = [Person.new('Dad', 'Daigle'), Person.new('Mom', 'NotDaigle')]
    @ryan.parents = @ryan_parents
    @ryan_children = [Person.new('Child1', 'Daigle'), Person.new('Child2', 'NotDaigle')]
    @ryan.children = @ryan_children
  end
  
  it "should know if a person's parents are divorced" do
     @ryan.parents.divorced?.should be_true
  end
  
  it "should know how to print out parents names' to a string when divorced" do
    @ryan.parents.to_s.should == "Dad Daigle and Mom NotDaigle"
  end
  
  it "should know how to get a person's step-children" do
    @ryan.children.step.should == [@ryan_children.last]
  end
end