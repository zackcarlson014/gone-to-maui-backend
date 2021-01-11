require 'pry'

class SessionsController < ApplicationController

    def omniauth
        user = User.find_or_create_by(uid: auth['uid'], provider: auth('provider')) do |u|
          u.firstname = auth['info']['first_name']
          u.lastname = auth['info']['last_name']
          u.email = auth['info']['email']
          u.image = auth['info']['image']
        end
        if user
            jwt = Auth.encode_uid(user.uid)
            redirect_to(ENV['DIVE_LOG_CLIENT_URL'] + "?token=#{jwt}")
        end
        render json: user
    end



    private 

    def auth
      request.env['omniauth.auth']
    end
end