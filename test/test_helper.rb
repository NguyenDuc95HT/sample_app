ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  fixtures :all

  def is_logged_in?
    session[:user_id].present?
  end
  # Add more helper methods to be used by all tests here...
end
