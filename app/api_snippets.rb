# Start of a new api

class API < Sinatra::base
  def initialize(ledger:)
    @ledger = ledger
    super() # rest of initialization from Sinatra
  end
end

# Later, callers do this:
app = API.new(ledger: Ledger.new)
