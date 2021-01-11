require 'pry'

class Api::V1::AuthController < ApplicationController
  binding.pry
    def create
      user = User.find_by(username: params[:username]) 
  
      if user && user.authenticate(params[:password])
          payload = { user_id: user.id }
          token = JWT.encode(payload, 'hush_child', 'HS256')
          render json: {user: {id: user.id, username: user.username, firstname: user.firstname, lastname: user.lastname, bio: user.bio, image: user.image, location: user.location}, token: token}
      else
        render json: { error: 'Invalid username/password.' }, status: 401
      end
    end

    def show
      token = request.headers[:Authorization].split(' ')[1]
      decoded_token = JWT.decode(token, 'hush_child' , true, { algorithm: 'HS256' })
      user_id = decoded_token[0]['user_id']
      user = User.find(user_id)
      render json: {user: {id: user.id, username: user.username, firstname: user.firstname, lastname: user.lastname, bio: user.bio, image: user.image, location: user.location}, token: token}
    end
end