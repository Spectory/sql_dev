##################################################################################
# In order to use this controller:
#   1 - Create a custom controller that inherites from it
#   2 - Add an environment variable named like: YOURAPP_AUTH_TOKEN whose value is
#       a badass random token
#
# You can now call your action using either a URL parmater like this:
#
#    curl "http://localhost:3000/<your action>?token=<your token>"
#
# Or include the token as part of the call header:
#
#    curl -v -H "token: <your token>" "http://localhost:3000/<your action>"
##################################################################################


class ApiController < ActionController::Base

  before_action :authenticate_call
  around_action :error_handler_wrapper

  private

  def authenticate_call
    token = request.headers['token'] || params['token']
    render json: { result: 'error', message: 'unauthenticcated', status: 401} if !client_auth(token)
  end

  def client_auth(token)
    return true  if Rails.env.test?
    return false if token.nil?
    app_name = Rails.application.class.parent_name.upcase
    return true  if (token == ENV["#{app_name}_AUTH_TOKEN"])
    return false
  end

  def error_handler_wrapper
    begin
      yield
    rescue Exception => e
      puts "\n\nEXCEPTION: #{e.message}" unless Rails.env.test?
      puts e.backtrace.join("\n") unless Rails.env.test?
      render json: { result: 'error', message: e.message, status: 500}
    end
  end
end
