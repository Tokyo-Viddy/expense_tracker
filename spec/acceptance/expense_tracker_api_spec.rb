# Start of the tests for the expense tracker api

require 'rack/test'
require 'json'
require_relative '../../app/api'

module ExpenseTracker
  RSpec.describe 'Expense Tracker API' do
    include Rack::Test::Methods

    def app
      ExpenseTracker::API.new
    end

    def post_expense(expense)
      post '/expenses', JSON.generate(expense)
      expect(last_response.status).to eq(200)

      parsed = JSON.parse(last_response.body)
      expect(parsed).to include('expense_id' => a_kind_of(Integer))
      expense.merge('id' => parsed['expense_id'])
    end

    it 'records submitted expenses' do
      pending 'Need to persist expenses'
      coffee = post_expense(
        'payee'  => 'Starbucks',
        'amount' => 575,
        'date'   => '2021-09-12'
      )

      zoo = post_expense(
        'payee'  => 'Zoo',
        'amount' => 1525,
        'date'   => '2021-09-12'
      )

      groceries = post_expense(
        'payee'  => 'Summit',
        'amount' => 9520,
        'date'   => '2021-09-13'
      )

      get '/expenses/2021-09-12'
      expect(last_response.status).to eq(200)

      expenses = JSON.parse(last_response.body)
      expect(expenses).to contain_exactly(coffee, zoo)
    end
  end
end
