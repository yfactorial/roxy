require File.join(File.dirname(__FILE__), *%w[abstract_spec])

describe "Proxy" do
  
  before(:each) do
    @owner = Object.new
    @target = Object.new
    @lambda_target = lambda { @target }
  end

  it "should have a reference to the proxy owner" do
    proxy = Roxy::Proxy.new(@owner, :to => @target)
    proxy.owner.should == @owner
  end

  it "should have a reference to the proxy target" do
    proxy = Roxy::Proxy.new(@owner, :to => @target)
    proxy.target.should == @target
  end

  it "should properly evaluate a block-based target" do
    proxy = Roxy::Proxy.new(@owner, :to => @lambda_target)
    proxy.target.should == @target
  end
  
  it "should properly adorn the proxy with proxy methods" do
    proxy = Roxy::Proxy.new(@owner, :to => @target) do
      def poop; 'poop'; end
    end
    proxy.poop.should == 'poop'
  end
end