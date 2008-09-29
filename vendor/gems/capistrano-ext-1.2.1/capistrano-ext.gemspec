
# Gem::Specification for Capistrano-ext-1.2.1
# Originally generated by Echoe

Gem::Specification.new do |s|
  s.name = %q{capistrano-ext}
  s.version = "1.2.1"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jamis Buck"]
  s.date = %q{2008-06-14}
  s.description = %q{Useful task libraries and methods for Capistrano}
  s.email = %q{jamis@jamisbuck.org}
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "lib/capistrano/ext/assets/request-counter.rb", "lib/capistrano/ext/monitor.rb", "lib/capistrano/ext/multistage.rb", "lib/capistrano/ext/version.rb", "README"]
  s.files = ["CHANGELOG.rdoc", "lib/capistrano/ext/assets/request-counter.rb", "lib/capistrano/ext/monitor.rb", "lib/capistrano/ext/multistage.rb", "lib/capistrano/ext/version.rb", "MIT-LICENSE", "README", "setup.rb", "Manifest", "capistrano-ext.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://www.capify.org}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Capistrano-ext", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{capistrano-ext}
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{Useful task libraries and methods for Capistrano}

  s.add_dependency(%q<capistrano>, [">= 1.0.0"])
end


# # Original Rakefile source (requires the Echoe gem):
# 
# begin
#   require 'echoe'
# rescue LoadError
#   abort "You'll need to have `echoe' installed to use capistrano-ext's Rakefile"
# end
# 
# require "./lib/capistrano/ext/version"
# 
# version = Capistrano::Ext::Version::STRING.dup
# if ENV['SNAPSHOT'].to_i == 1
#   version << "." << Time.now.utc.strftime("%Y%m%d%H%M%S")
# end
# 
# Echoe.new('capistrano-ext', version) do |p|
#   p.changelog        = "CHANGELOG.rdoc"
# 
#   p.author           = "Jamis Buck"
#   p.email            = "jamis@jamisbuck.org"
#   p.summary          = "Useful task libraries and methods for Capistrano"
#   p.url              = "http://www.capify.org"
# 
#   p.need_zip         = true
# 
#   p.dependencies     = ["capistrano >=1.0.0"]
# end