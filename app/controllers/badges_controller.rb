class BadgesController < ApplicationController

  def show
    @badges = Badge.all
  end

end
