class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
  @user = User.find(params[:id])
  @tweets = @user.tweets.order(created_at: :desc)
end

  def active_years
    return nil unless started_at
    now = Date.today.year
    (now - started_at.year)
  end

  def active_tag
    return nil unless active_years
    case active_years
    when 0..2
      "0〜3年目"
    when 3..4
      "3〜5年目"
    when 5..9
      "5〜10年目"
    else
      "10年以上"
    end
  end
end
