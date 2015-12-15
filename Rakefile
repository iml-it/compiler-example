$: << File.join(File.expand_path('../lib', __FILE__))

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

require 'php_to_ruby'

task :compile do
  PhpToRuby.translate(File.join('files', 'script.php'), File.join('files', 'script.rb'))
end
