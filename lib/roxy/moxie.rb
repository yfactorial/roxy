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
        
        # If we're proxying an existing method, we need to store
        # the original method and move it out of the way so
        # we can take over
        if original_method        
          new_method = "proxied_#{name}"
          alias_method new_method, "#{name}"
          options[:to] = original_method
        end
        
        # Thanks to Jerry for this simplification of my original class_eval approach
        # http://ryandaigle.com/articles/2008/11/10/implement-ruby-proxy-objects-with-roxy/comments/8059#comment-8059
        if !original_method or original_method.arity == 0
          define_method name do
            (@proxy_for ||= {})[name] ||= Proxy.new(self, options, nil, &block)
          end
        else
          define_method name do |*args|
            Proxy.new(self, options, args, &block)
          end
        end      
      end
      
    end
  end
end