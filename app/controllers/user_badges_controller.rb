class UserBadgesController < ApplicationController
  before_action :set_user_badges, only: %i[show]

  private

  def set_user_badges
    @user_badges = current_user.badges
  end
end