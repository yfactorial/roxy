module Roxy

  # The very simple proxy class that provides a basic pass-through
  # mechanism between the proxy owner and the proxy target.
  class Proxy
    
    alias :proxy_instance_eval :instance_eval
    alias :proxy_extend :extend
    
    # Make sure the proxy is as dumb as it can be.
    # Blatanly taken from Jim Wierich's BlankSlate post:
    # http://onestepback.org/index.cgi/Tech/Ruby/BlankSlate.rdoc
    instance_methods.each { |m| undef_method m unless m =~ /(^__|^proxy_)/ }
    
    def initialize(owner, options, &block)
      @owner = owner
      @target = options[:to]      
      
      # Adorn with user-provided proxy methods
      [options[:extend]].flatten.each { |ext| proxy_extend(ext) } if options[:extend]
      proxy_instance_eval &block if block_given?      
    end
      
    def proxy_owner; @owner; end
    def proxy_target
      @proxy_target_object ||= @target.is_a?(Proc) ? @target.call(@owner) : @target
    end
  
    # Delegate all method calls we don't know about to target object
    def method_missing(sym, *args, &block)
      proxy_target.__send__(sym, *args, &block)
    end
  end
end