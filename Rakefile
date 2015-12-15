$: << File.join(File.expand_path('../lib', __FILE__))

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

require 'php_to_ruby'

desc 'compiles a very simple PHP script to Ruby'
task :compile_simple do
  PhpToRuby.translate('files/simple_script.php', 'files/simple_script.rb')
end

desc 'compiles a normal PHP script to Ruby'
task :compile do
  PhpToRuby.translate('files/normal_script.php', 'files/normal_script.rb')
end

desc 'compiles a much more complicated PHP script to Ruby'
task :compile_complicated do
  PhpToRuby.translate('files/complicated_script.php', 'files/complicated_script.rb')
end
