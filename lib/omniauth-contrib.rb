require "omniauth-contrib/version"
require "omniauth"

module OmniAuth
  module Strategies
    autoload :Twitter,  'omniauth/strategies/twitter'
    autoload :GitHub,   'omniauth/strategies/github'
    autoload :Facebook, 'omniauth/strategies/facebook'
  end
end

OmniAuth.config.add_camelization 'github', 'GitHub'
