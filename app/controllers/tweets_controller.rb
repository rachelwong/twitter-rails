class TweetsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tweet, only: [:show, :edit, :update, :destroy]
    before_action :check_edit, only: [:edit, :update]
    before_action :check_destroy, only: [:edit, :update]
    # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
    # if curretn user is NOT owner of tweet
    
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user 

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def check_edit
      if !@tweet.can_edit?(current_user)
      # if current_user != @tweet.user && !current_user.has_role?(:admin)
        flash[:alert] = "You cannot edit that tweet!"
        redirect_to(request.referrer)
      end
    end

    def check_destroy
      if !@tweet.can_destroy?(current_user)
      # if current_user != @tweet.user && !current_user.has_role?(:admin)
        flash[:alert] = "You cannot delete that tweet!"
        redirect_to(request.referrer)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:title, :content)
    end
end
