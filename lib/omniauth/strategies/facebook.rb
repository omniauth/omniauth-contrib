require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Facebook < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://graph.facebook.com',
        :token_url => '/oauth/access_token'
      }
      option :scope, ''
      option :mobile, false
      option :token_params, {:parse => :query}

      uid { raw_info['id'] }
      info do
        {
          'nickname' => raw_info['username'],
          'email' => raw_info['email'],
          'first_name' => raw_info['first_name'],
          'last_name' => raw_info['last_name'],
          'image' => "http://graph.facebook.com/#{raw_info['id']}/picture?type=square",
          'urls' => {
            'Facebook' => raw_info['link'],
            'Website' => raw_info['website'],
          }
        }.delete_if{|k,v| v.nil?}
      end

      def request_phase
        options.authorize_params[:display] = 'wap' if options.mobile?
        super
      end

      def raw_info
        access_token.options[:mode] = :query
        access_token.options[:param_name] = 'access_token'
        @raw_info ||= access_token.get('/me').parsed
      end

      def build_access_token
        if facebook_session.nil? || facebook_session.empty?
          super
        else
          self.access_token = ::OAuth2::AccessToken.new(client, facebook_session['access_token'], {:mode => :query, :param_name => 'access_token'})
        end
      end

      def facebook_session
        session_cookie = request.cookies["fbs_#{client.id}"]
        if session_cookie
          @facebook_session ||= Rack::Utils.parse_query(request.cookies["fbs_#{client.id}"].gsub('"', ''))
        else
          nil
        end
      end
    end
  end
end
