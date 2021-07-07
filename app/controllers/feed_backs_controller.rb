class FeedBacksController < ApplicationController

  def new
    @feed_back = FeedBack.new
  end

  def create
    @feed_back = FeedBack.new(feed_back_params)

    if @feed_back.save
      TestsMailer.send_feed_back(@feed_back).deliver_now
      redirect_to root_path, notice: t('.success')
    else
      render :new
    end
  end

  private

  def feed_back_params
    params.require(:feed_back).permit(:name, :email, :header, :message)
  end

end
