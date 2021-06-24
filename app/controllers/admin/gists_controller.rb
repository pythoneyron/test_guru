class Admin::GistsController < Admin::BaseController
  skip_before_action :authenticate_user!, raise: false

  def index
    @gists = Gist.all
  end

end
