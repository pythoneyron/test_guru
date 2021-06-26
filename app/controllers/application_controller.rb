class ApplicationController < ActionController::Base

  Dotenv::Railtie.load

  before_action :set_locale

  def after_sign_in_path_for(resource)
    current_user.is_a?(Admin) ? admin_tests_path : tests_path
  end

  def default_url_options
    { lang: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  private

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end
end
