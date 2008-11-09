class Person
  
  include Roxy::Moxie
  
  proxy :children, :to => ['child1', 'child2'] do
    def cost
      100 * target.size
    end
  end
  
  proxy :parents, :to => lambda { ['parent1', 'parent2'] }
  
  module NeighborGeographics
    def nearby?; true; end
  end
  
  module NeighborDemographics
    def caucasian?; false; end
  end
  
  proxy :neighbors, :to => ['neighbor1', 'neighbor2'], :extend => [NeighborGeographics, NeighborDemographics]
end