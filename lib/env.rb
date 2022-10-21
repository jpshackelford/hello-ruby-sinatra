begin

ENV['HOME'] = '/'
ENV['GEM_HOME'] = '/.gem'

# Install awesome_print to local directory
# GEM_HOME=${PWD}/.gem gem install awesome_print
require 'awesome_print'

puts 'Content-Type: text/plain; charset=UTF-8'
puts 'Status: 200'
puts

puts 'Hello from ruby!'
puts
puts "ruby version: #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"

puts

puts '### ARGV[0] ###'
puts
puts "$0            : #{$0}"
puts "__FILE__      : #{__FILE__}"
puts "$PROGRAM_NAME : #{$PROGRAM_NAME}"

puts

puts '### Arguments ###'
    ap ARGV
puts

puts '### Env Vars ###'
ap ENV.sort_by{|key| key }.to_h
puts

puts '### Files ###'
puts "Dir.children('usr'):"
ap Dir.children('usr') 

puts "Dir.children('.gem'):"
ap Dir.children('.gem') 

puts "Dir.children('lib'):"
ap Dir.children('lib')  

puts "Dir.children('/'):"
ap Dir.children('/')    

puts "pwd:"
puts Dir.pwd

puts '### stdin ###'
$stdin.each_line do |line|
    puts line
end
puts '### end ###'
puts

puts '### Query Params'
require 'cgi'
cgi = CGI.new
ap cgi.params

rescue => e
    puts
    puts '### ERROR ###'
    ap e
    puts
end

