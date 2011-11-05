require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class VKontakte < OmniAuth::Strategies::OAuth2
      option :client_options, {
          :site => 'https://vkontakte.ru',
          :authorize_url => 'http://api.vkontakte.ru/oauth/authorize',
          :token_url => 'https://api.vkontakte.ru/oauth/token'
      }

      def request_phase
        super
      end

      uid { access_token['user_id'] }

      info do
        {
            'nickname' => raw_info['nickname'],
            'first_name' => raw_info['first_name'],
            'last_name' => raw_info['last_name'],
            'email' => raw_info['email'],
            'image' => raw_info['photo'],
            'name' => raw_info['name'],
            'urls' => {
                'VKontakte' => "http://vkontakte.ru/#{raw_info['domain']}"
            },
        }
      end
      extra do
        {
            "gender" => raw_info["sex"],
            "timezone" => raw_info["timezone"],
            "photo_big" => raw_info["photo_big"], # 200px maximum resolution of the avatar (http://vkontakte.ru/developers.php?o=-17680044&p=Description+of+Fields+of+the+fields+Parameter)
            # according to http://vkontakte.ru/developers.php?o=-17680044&p=Description+of+Fields+of+the+fields+Parameter
            # it returns only: university_id, university_name, faculty_id, faculty_name, graduation
            "university_id" => raw_info["university"],
            "university_name" => raw_info["university_name"],
            "faculty_id" => raw_info["faculty"],
            "faculty_name" => raw_info["faculty_name"],
            "graduation" => raw_info["graduation"]
        }
      end

      def raw_info
        # http://vkontakte.ru/developers.php?o=-17680044&p=Description+of+Fields+of+the+fields+Parameter
        @fields ||= ['uid', 'first_name', 'last_name', 'nickname', 'domain', 'sex', 'bdate', 'city', 'country', 'timezone', 'photo', 'photo_big', 'education']
        @raw_info ||= access_token.get("https://api.vkontakte.ru/method/getProfiles?uid=#{access_token['user_id']}&fields=#{@fields.join(',')}&access_token=#{access_token.token}").parsed["response"][0]
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
    end
  end
end

OmniAuth.config.add_camelization 'vkontakte', 'VKontakte'