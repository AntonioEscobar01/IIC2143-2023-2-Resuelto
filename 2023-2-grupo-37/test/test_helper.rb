require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  SimpleCov.start 'rails' do
    add_group 'Models', 'app/models'
    add_group 'Controllers', 'app/controllers'
    add_group 'Helpers', 'app/helpers'
    add_group 'Mailers', 'app/mailers'
    add_group 'jobs', 'app/jobs'
    add_group 'channels', 'app/channels'
    add_group 'views', 'app/views'
    add_group 'config', 'config'
    add_group 'lib', 'lib'
    add_group 'Test', 'test'
  end

  # Add more helper methods to be used by all tests here...
end
