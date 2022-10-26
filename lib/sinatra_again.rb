
  require_relative "hacks/rackup_handler"
  require_relative "hacks/sinatra_base"     # I'd like to move this into sinatra_classic but
  require_relative "hacks/sinatra_classic"  # get wasm `unreachable` instruction executed
  

  get "/" do
    "Hello World!"
  end

  get "/hi" do
    "Hello, again!"
  end

 
  # We have to add this because wasm doesn't like
  # Sinatra's  at_exit tick.
  Sinatra.safe_run!

