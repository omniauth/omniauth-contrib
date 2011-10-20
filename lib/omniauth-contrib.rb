require "omniauth-contrib/version"
require "omniauth"

module OmniAuth
  module Strategies
    autoload :Twitter,  'omniauth/strategies/twitter'
    autoload :GitHub,   'omniauth/strategies/github'
    autoload :OpenID,   'omniauth/strategies/openid'
  end
end

OmniAuth.config.add_camelization 'github', 'GitHub'
OmniAuth.config.add_camelization 'openid', 'OpenID'
OmniAuth.config.add_camelization 'open_id', 'OpenID'
