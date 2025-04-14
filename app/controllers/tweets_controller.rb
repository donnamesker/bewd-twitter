class TweetsController < ApplicationController
  def index
    @tweets = Tweet.includes(:user).order(created_at: :desc)

    render json: {
      tweets: @tweets.map { |tweet|
        {
          id: tweet.id,
          username: tweet.user.username,
          message: tweet.message
        }
      }
    }
  end

  def index_by_user
    @user = User.find_by(username: params[:username])
    if @user
      @tweets = @user.tweets

      render json: {
        tweets: @tweets.map { |tweet|
          {
            id: tweet.id,
            username: tweet.user.username,
            message: tweet.message
          }
        }
      }
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def show
      @tweet = Tweet.find(params[:id])
  end

  def create
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user
      @tweet = user.tweets.new(tweet_params)

      if @tweet.save
        render json: {
          tweet: {
            username: user.username,
            message: @tweet.message
          }
        }
      else
          render json: {
              success: false
          }
      end
    else
      render json: {
          success: false
      }
    end
  end

  def destroy
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session

      tweet = Tweet.find(params[:id])

      if tweet and tweet.destroy
          render json: {
              success: true
          }
      else
        render json: { 
          success: false
        }
      end
    else
      render json: {
          success: false
      }
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:username, :message)
  end
end