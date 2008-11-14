module Roxy
  module Moxie
    
    def self.included(within)
      within.class_eval { extend ClassMethods }
    end
    
    module ClassMethods
      
      # Set up this class to proxy on the given name
      def proxy(name, options = {}, &block)
        
        # Make sure args are OK
        original_method = method_defined?(name) ? instance_method(name) : nil
        raise "Cannot proxy an existing method, \"#{name}\", and also have a :to option.  Please use one or the other." if
          original_method and options[:to]  
        
        # If we're proxying an existing method, we need to move it out
        # of the way so we can take over
        if original_method        
          new_method = "proxied_#{name}"
          alias_method new_method, "#{name}"
          options[:to] = lambda { |owner| owner.send(new_method) }
        end
        
        roxy_proxy_methods[name] = [options, block]
        
        # If we have a no-arg method we're proxying, or if we're not
        # proxying an existing method at all, we can do a basic def
        if !original_method or original_method.arity == 0
          class_eval <<-EOS, __FILE__, __LINE__
            def #{name}
              @#{name}_proxy ||= Proxy.new(self, self.class.roxy_proxy_methods[:#{name}][0],
                                                 &self.class.roxy_proxy_methods[:#{name}][1])
            end
          EOS
          
        # If we have a proxied method with arguments, we need to
        # retain them
        # else
        #           class_eval <<-EOS, __FILE__, __LINE__
        #             def #{name}(*args)
        #               @#{name}_proxy ||= Proxy.new(self, self.class.roxy_proxy_methods[:#{name}][0],
        #                                                  &self.class.roxy_proxy_methods[:#{name}][1])
        #             end
        #           EOS
                              
        end        
      end
            
      def roxy_proxy_methods
        @roxy_proxy_methods ||= {}
      end
    end
  end
end