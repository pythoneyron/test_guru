class Admin::BadgesController < Admin::BaseController

  before_action :set_badge, only: %i[show destroy edit update ]

  def index
    @badges = Badge.all
  end

  def create
    @badge = current_user.badges.new(badge_params)

    if @badge.save
      redirect_to admin_badge_path(@badge), notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @badge.update(badge_params)
      redirect_to admin_badge_path(@badge)
    else
      render :new
    end
  end

  def new
    @badge = Badge.new
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end

  private

  def set_badge
    @badge = Badge.find(params[:id])
  end

  def badge_params
    params.require(:badge).permit(:title, :url_image, :rule)
  end
end
