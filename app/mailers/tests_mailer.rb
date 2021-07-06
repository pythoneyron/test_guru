class TestsMailer < ApplicationMailer

  def completed_test(test_passage)
    @user = test_passage.user
    @test = test_passage.test

    mail to: @user.email
  end

  def send_feed_back(feed_back)
    @feed_back = feed_back
    mail to: User.find_by(type: 'Admin').email
  end
end
