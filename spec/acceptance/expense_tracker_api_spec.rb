# Start of the tests for the expense tracker api

require 'rack/test'
require 'json'

module ExpenseTracker
  RSpec.describe 'Expense Tracker API' do
    include Rack::Test::Methods

    it 'records submitted expenses' do
      coffee = {
        'payee' => 'Starbucks',
        'amount' => 575,
        'date' => '2021-09-12'
      }

      post '/expenses', JSON.generate(coffee)
    end
  end
end
