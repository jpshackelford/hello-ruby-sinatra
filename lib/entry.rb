begin
  loaded = require_relative("rackup_handler")

  class Application
    def call(env)
      [200, { "Content-Type" => "text/plain" }, ["Hello, Rack!"]]
    end
  end

  app = Application.new

  Rackup::Handler::CGI.run(app)
rescue => e
  puts "Content-Type: text/plain; charset=UTF-8"
  puts "Status: 200"
  puts
  puts
  puts "### ERROR ###"
  puts "#{e.class}  #{e.message}"
  puts e.backtrace.join("\n")
  puts
end
