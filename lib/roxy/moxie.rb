module Roxy
  module Moxie
    
    def self.included(within)
      within.class_eval { extend ClassMethods }
    end
    
    module ClassMethods
      
      # Set up this class to proxy on the given name
      def proxy(name, options = {}, &block)  
        
        # If we don't have the :to option then we are proxying an existing
        # method
        if(!options[:to])
          alias_method "proxied_#{name}", "#{name}"
          options[:to] = lambda { |owner| owner.send("proxied_#{name}") }
        end
        
        define_method(name) do
          instance_variable_get("@#{name}_proxy") ||
            instance_variable_set("@#{name}_proxy", Proxy.new(self, options, &block))
        end
      end
    end
  end
end