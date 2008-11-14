require File.join(File.dirname(__FILE__), *%w[abstract_spec])

describe "Roxy" do

  before do
    uses_fixture(:person)
    @person = Person.new
  end

  it "should return the target when the proxy name is called" do
    @person.children.should == ['child1', 'child2']
  end
  
  it "should return the evaluated target if the target is an existing method" do
    @person.parents.should == ['parent1', 'parent2']
  end
  
  it "should return the evaluated target if the target is a proc" do
    @person.neighbors.should == ['neighbor1', 'neighbor2']
  end
  
  it "should pass method invocations through to the target" do
    @person.children.size.should == 2
  end
  
  it "should intercept block-based proxy methods" do
    @person.children.cost.should == 200
    @person.parents.divorced?.should be_false
  end
  
  it "should intercept :extend based proxy methods" do
    @person.neighbors.nearby?.should be_true
    @person.neighbors.caucasian?.should be_false
  end
  
  it "should be able to pass arguments through the proxy" do
    @person.ancestors(true, false).should == ['m_ancestor1', 'm_ancestor2']
    @person.ancestors(false, true).should == ['p_ancestor1', 'p_ancestor2']
    @person.ancestors(true, true).should == ['m_ancestor1', 'm_ancestor2'] + ['p_ancestor1', 'p_ancestor2']    
  end
  
  it "should be able to retain default argument values" do
    @person.ancestors.should == ['m_ancestor1', 'm_ancestor2'] + ['p_ancestor1', 'p_ancestor2'] 
  end
  
  it "should be able to call a proxy method through a method with arguments" do
    @person.ancestors(true, false).men.should == ['m_ancestor1']
    @person.ancestors(true, false).women.should == ['m_ancestor2']
    @person.ancestors(false, true).men.should == ['p_ancestor1']
    @person.ancestors(false, true).women.should == ['p_ancestor2']
    @person.ancestors(true, true).men.should == ['p_ancestor1', 'm_ancestor1']
    @person.ancestors.women.should == ['p_ancestor2', 'm_ancestor2']
  end
end