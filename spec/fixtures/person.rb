class Person
  
  include Roxy::Moxie
  
  proxy :children, :to => ['child1', 'child2'] do
    def cost
      100 * proxy_target.size
    end
  end
  
  def parents
    ['parent1', 'parent2']
  end
  
  proxy :parents do
    def divorced?
      proxy_target.size < 2
    end
  end
  
  module NeighborGeographics
    def nearby?; true; end
  end
  
  module NeighborDemographics
    def caucasian?; false; end
  end
  
  proxy :neighbors, :to => ['neighbor1', 'neighbor2'], :extend => [NeighborGeographics, NeighborDemographics]
end