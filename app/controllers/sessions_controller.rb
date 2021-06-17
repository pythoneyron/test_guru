class SessionsController < Devise::SessionsController

  def create
    super # вызов метода родителя
    flash.notice = "Привет, #{current_user.first_name}" if current_user and not current_user.admin?
  end

end
