require File.join(File.dirname(__FILE__), *%w[abstract_spec])

describe "Proxy" do
  
  before(:each) do
    @owner = "String owner"
    @target = "String target"
    @lambda_target = lambda { @target }
  end

  it "should properly evaluate a block-based target" do
    proxy = Roxy::Proxy.new(@owner, :to => @lambda_target)
    proxy.should == @target
  end
  
  it "should properly adorn the proxy with proxy methods" do
    proxy = Roxy::Proxy.new(@owner, :to => @target) do
      def poop; 'poop'; end
    end
    proxy.poop.should == 'poop'
  end
  
  it "should make the proxy owner accessible to the target block" do
    proxy = Roxy::Proxy.new(@owner, :to => lambda { |owner| owner })
    proxy.should == @owner
  end
    
end