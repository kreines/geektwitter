class LikesController < ApplicationController
    def create
    like = current_user.likes.create(tweet_id: params[:tweet_id]) #user_idとtweet_idの二つを代入
    redirect_to params[:return_to] || root_path
    end

    def destroy
    like = Like.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
    like.destroy
    redirect_to params[:return_to] || root_path
    end
end
