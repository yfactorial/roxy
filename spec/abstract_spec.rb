require File.join(File.dirname(__FILE__), *%w[spec_helper])

$:.unshift "#{File.dirname(__FILE__)}/../lib"
require 'roxy'

# Load a test class
def uses_fixture(fixture_name)
  require File.join(File.dirname(__FILE__), 'fixtures', fixture_name.to_s)
end