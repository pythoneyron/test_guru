class UserBadgesController < ApplicationController

  def show
    @user_badges = current_user.badges
  end

end