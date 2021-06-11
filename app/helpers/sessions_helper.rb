module SessionsHelper
  def flash_alert(flash)
    if flash[:alert]
      content_tag :p, flash[:alert], class: 'flash alert'
    end
  end
end
