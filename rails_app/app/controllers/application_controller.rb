class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def robots
    user_agents = '*'
    disallow = '/'
    res = ''
    if ENV['BLOCK_BOTS']
      res = [
        "User-agent: #{user_agents} # we don't like those bots",
        "Disallow: #{disallow} # block bots access to those paths"
      ].join("\n")
    end
    render text: res, layout: false, content_type: 'text/plain'
  end
end
