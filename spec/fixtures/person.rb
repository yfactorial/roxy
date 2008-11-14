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
  
  def ancestors(maternal = true, paternal = true)
    paternal_ancestors = ['p_ancestor1', 'p_ancestor2']
    maternal_ancestors = ['m_ancestor1', 'm_ancestor2']
    (maternal ? maternal_ancestors : []) + (paternal ? paternal_ancestors : [])
  end
  
  proxy :ancestors do
    def men
      proxy_target.select { |ancestor| ancestor[-1, 1] == '1' }
    end
    
    def women
      proxy_target.select { |ancestor| ancestor[-1, 1] == '2' }
    end
  end
end