module Roxy
  module Moxie
    
    def self.included(within)
      within.class_eval { extend ClassMethods }
    end
    
    module ClassMethods
      
      # Set up this class to proxy on the given name
      def proxy(name, options, &block)        
        class_eval do          
          define_method(name) do
            instance_variable_get("@#{name}") ||
              instance_variable_set("@#{name}", Proxy.new(self, options, &block))
          end
        end
      end
    end
  end
end