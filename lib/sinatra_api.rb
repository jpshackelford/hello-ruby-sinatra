begin
  require_relative "rackup_handler"
  require_relative "sinatra_base"

  class MyApp < Sinatra::Base
    get "/" do
      "Hello World!"
    end

    get "/hi" do
      "Hello, again!"
    end
  end

  Rackup::Handler::CGI.run(MyApp.new)

  #MyApp.start_server(:handler => handler, MyApp.settings, 'cgi')

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
