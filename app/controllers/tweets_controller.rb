class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 基本のツイート（User と一緒に取得）
    @tweets = Tweet.joins(:user).includes(:user).order(created_at: :desc)
    @rank_tweets = Tweet.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}

    # 部分検索
    if params[:search].present?
      @tweets = @tweets.where("tweets.body LIKE ?", "%#{params[:search]}%")
    end

     # カテゴリーで絞り込み
    if params[:category].present?
      @tweets = @tweets.where(category: params[:category])
    end
    
    # 活動年数での絞り込み
if params[:active_years].present?
  today = Date.today

  @tweets = @tweets.select do |tweet|
    next false unless tweet.user&.started_at

    # 実際の経過年数（日付差で計算）
    active_years = ((today - tweet.user.started_at) / 365.25).floor

    case params[:active_years]
    when "0-1"
      active_years < 1                     # 1年未満
    when "1-4"
      (1..3).cover?(active_years)          # 1年以上4年未満
    when "4-10"
      (4..9).cover?(active_years)          # 4年以上10年未満
    when "10+"
      active_years >= 10                   # 10年以上
    else
      true
    end
  end
end

  # 最近投稿された動画（YouTubeあり）を直近30件
  @recent_videos = Tweet.where.not(youtube_url: nil)
                        .order(created_at: :desc)
                        .limit(20)

  # いいね数ランキングを上位20件
  @rank_tweets = Tweet.all.sort { |a, b| b.liked_users.count <=> a.liked_users.count }
                          .first(20)
  end  # ← ここが index の end
  

  def new
    @tweet = Tweet.new
  end

  def show
    @tweet = Tweet.find(params[:id])

    @comments = @tweet.comments
    @comment = Comment.new
  end
  
  def edit
    @tweet = Tweet.find(params[:id])
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id

    if tweet.save
      redirect_to action: "index"
    else
      redirect_to action: "new"
    end
  end

  # カテゴリー分けに関連するところのみ記載
  def music
    @Tweets = Post.all
  end

  def video
    @Tweets = Post.all
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to action: "show", id: tweet.id
    else
      redirect_to action: "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

def comments_list
  @tweet = Tweet.find(params[:id])
  @comments = @tweet.comments.includes(:user)
  render partial: "comments/comments_list", locals: { tweet: @tweet, comments: @comments }
end


  private

  def tweet_params
  params.require(:tweet).permit(:body, :image, :youtube_url, :cotent, :category)
end
end