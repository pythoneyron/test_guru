class BadgesController < ApplicationController

  before_action :set_badges, only: %i[show]


  private

  def set_badges
    @badges = Badge.all
  end

end
