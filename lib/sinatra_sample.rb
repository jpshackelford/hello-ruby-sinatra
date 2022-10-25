begin
  require_relative "hacks/rackup_handler"
  require_relative "hacks/sinatra_base"

  class MyApp < Sinatra::Base
    get "/" do
      "Hello World!"
    end

    get "/hi" do
      "Hello, again!"
    end
  end

  Rackup::Handler::CGI.run(MyApp.new)

  #handler = Rackup::Handler::CGI
  #MyApp.start_server(handler, MyApp.settings, 'cgi')

rescue Exception => e
  puts "Content-Type: text/plain; charset=UTF-8"
  puts "Status: 200"
  puts
  puts
  puts "### ERROR ###"
  puts "#{e.class}  #{e.message}"
  puts e.backtrace.join("\n")
  puts
end
