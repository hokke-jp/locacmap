ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # OLD: parallelize(workers: :number_of_processors)  <--
  parallelize(workers: 1) # i.e don't run tests in parallel via forked processes
  # OR just comment the line above out completely <--

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def is_logged_in?
    !session[:user_id].nil?
  end
end