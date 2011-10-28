require "omniauth-contrib/version"
require "omniauth"

module OmniAuth
  module Strategies
    autoload :Twitter,  'omniauth/strategies/twitter'
  end
end

OmniAuth.config.add_camelization 'github', 'GitHub'
