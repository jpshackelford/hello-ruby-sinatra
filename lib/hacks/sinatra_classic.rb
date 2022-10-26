# Inspired by sinatra/main.rb

# Ideally for Sinatra classic, we'd just use Sinatra out-of-the-box.
# I had run into some problems with rackup not playing nice with wagi
# and hacked the CGI rackup handler to compensate. If we can figure
# how to resolve this and the problems with Rack::Protection, without
# our hacks, we'll be better off.

extend Sinatra::Delegator

class Rack::Builder
  include Sinatra::Delegator
end

#set :show_exceptions, true
#set :run, false

module Sinatra

  class Application < Base
    set :app_file, caller_files.first || $0
    set :run, proc { File.expand_path($0) == File.expand_path(app_file) }
    set :show_exceptions, true
  end

  # We have to add this because wasm doesn't like
  # Sinatra's  at_exit tick.
  module_function
  def safe_run!
    ::Rackup::Handler::CGI.run(Sinatra::Application.new)
  end

end
