Gem::Specification.new do |s|
  
  s.name     = "roxy"
  s.version  = "0.1.2"
  s.date     = "2008-11-11"
  
  s.summary  = "A Ruby library for quickly creating proxy objects."
  s.email    = "ryan@yfactorial.com"
  s.homepage = "http://github.com/yfactorial/roxy"
  s.description = "A Ruby library for quickly creating proxy objects."
  
  
  s.authors  = ["Ryan Daigle"]
  s.has_rdoc = true
  s.rdoc_options = ['--main', 'README.textile']
  s.rdoc_options << '--inline-source' << '--charset=UTF-8'
  s.extra_rdoc_files = ['README.textile', 'Rakefile', 'LICENSE', 'CHANGELOG']
  
  s.files = %w(README.textile Rakefile LICENSE CHANGELOG init.rb lib lib/roxy lib/roxy.rb lib/roxy/moxie.rb lib/roxy/proxy.rb spec spec/abstract_spec.rb spec/proxy_spec.rb spec/roxy_spec.rb spec/family_spec.rb spec/fixtures spec/fixtures/person.rb spec/fixtures/family.rb)
end
