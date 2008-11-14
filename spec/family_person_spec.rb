require File.join(File.dirname(__FILE__), *%w[abstract_spec])

describe "Whole family example" do

  before do
    uses_fixture(:family_person)
    @ryan = FamilyPerson.new('Ryan', 'Daigle')
    @ryan_parents = [FamilyPerson.new('Dad', 'Daigle'), FamilyPerson.new('Mom', 'Daigle')]
    @ryan.parents = @ryan_parents
    @ryan_children = [FamilyPerson.new('Child1', 'Daigle'), FamilyPerson.new('Child2', 'Daigle')]
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
    uses_fixture(:family_person)
    @ryan = FamilyPerson.new('Ryan', 'Daigle')
    @ryan_parents = [FamilyPerson.new('Dad', 'Daigle'), FamilyPerson.new('Mom', 'NotDaigle')]
    @ryan.parents = @ryan_parents
    @ryan_children = [FamilyPerson.new('Child1', 'Daigle'), FamilyPerson.new('Child2', 'NotDaigle')]
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

describe "Ancestors example" do
  
  before do
    uses_fixture(:family_person)
    @ryan = FamilyPerson.new('Ryan', 'Daigle')
  end
  
  it "should proxy through the ancestors method and retain arguments" do
    @ryan.ancestors(true).sort.should == ['rancestor1', 'rancestor3', 'rancestor2', 'rancestor4'].sort
  end
  
  it "should call proxied ancestor methods and retain arguments" do
    @ryan.ancestors(true).men.sort.should == ['rancestor1', 'rancestor3'].sort
    @ryan.ancestors(true).women.sort.should == ['rancestor2', 'rancestor4'].sort
    @ryan.ancestors(false).men.sort.should == ['ancestor1', 'ancestor3'].sort
    @ryan.ancestors(false).women.sort.should == ['ancestor2', 'ancestor4'].sort
  end
  
  it "should call proxied ancestor methods and retain default arguments" do
    @ryan.ancestors.men.sort.should == ['ancestor1', 'ancestor3'].sort
    @ryan.ancestors.women.sort.should == ['ancestor2', 'ancestor4'].sort
  end
end