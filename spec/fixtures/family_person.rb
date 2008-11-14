class FamilyPerson
  
  include Roxy::Moxie
  
  attr_accessor :first, :last, :parents, :children
  
  # Add ability to ask the parents collection if they are divorced
  # (As defined by not having the same last name).  Also print
  # them out as a string taking this into account
  proxy :parents do
    
    def divorced?
      proxy_target.size > 1 and proxy_target.collect { |parent| parent.last }.uniq.size > 1
    end
    
    def to_s
      if divorced?
        proxy_target.collect { |parent| parent.to_s }.join(' and ')
      else
        "Mr. and Mrs. #{proxy_target[0].last}"
      end
    end
  end
  
  # Add ability to ask the children collection for the list of
  # step-children
  proxy :children do
    def step
      proxy_target.select { |child| proxy_owner.last != child.last }
    end    
  end
  
  def initialize(first, last)
    @first, @last = first, last
  end
  
  def ancestors(reload = false)
    1.upto(4).to_a.collect { |i| "#{reload ? 'r' : ''}ancestor#{i}" }      
  end
  
  proxy :ancestors do
    def men
      proxy_target.select { |a| a.include?('1') || a.include?('3') }
    end
    def women
      proxy_target - men
    end
  end
  
  def to_s; "#{first} #{last}"; end
end