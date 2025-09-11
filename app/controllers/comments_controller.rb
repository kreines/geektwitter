class CommentsController < ApplicationController
  before_action :authenticate_user!

 def index
  @tweet = Tweet.find(params[:tweet_id])
  @comments = @tweet.comments

  render partial: "comments/comments_list", locals: { comments: @comments, tweet: @tweet }
end


def create
  @tweet = Tweet.find(params[:tweet_id])
  @comment = @tweet.comments.build(comment_params)
  @comment.user = current_user

  if @comment.save
      redirect_to mypage_path, notice: "コメントしました"
    else
      render "tweets/show", status: :unprocessable_entity
    end
  end

def comments_list
  @tweet = Tweet.find(params[:id])
  @comments = @tweet.comments.includes(:user)
  @comment = Comment.new

  if params[:from] == "mypage"
    render partial: "comments/mypage_comments_list", locals: { tweet: @tweet, comment: @comment }
  else
    render partial: "comments/comments_list", locals: { tweet: @tweet, comment: @comment }
  end
end



private

def comment_params
  params.require(:comment).permit(:content)
end
end

