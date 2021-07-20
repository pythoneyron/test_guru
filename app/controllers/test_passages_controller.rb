class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[ show result update gist check_timer ]

  def show; end

  def result; end

  def gist
    gist_obj = GistQuestionService.new(@test_passage.current_question)
    result = gist_obj.call

    if gist_obj.success?
      current_user.gists.create(
        question: @test_passage.current_question.body, hash_gist: result.id, link_to_gist: result.html_url)

      flash_options = { notice: t('.success', url: result.html_url) }
    else
      flash_options = { alert: t('.failure') }
    end

    redirect_to @test_passage, flash_options
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    unless time_is_left?
      @test_passage.update(success: false)
      return redirect_to result_test_passage_path(@test_passage), alert: 'Время вышло, тест не выполнен!'
    end

    if @test_passage.completed?
      @test_passage.update(success: true) if @test_passage.success?
      send_email_and_set_badge

      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def send_email_and_set_badge
    TestsMailer.completed_test(@test_passage).deliver_now
    TestPassageService.new(@test_passage).call_set_badges if @test_passage.success?
  end

  def time_is_left?
    return unless @test_passage.test.timer

    seconds = @test_passage.test.timer_on_seconds
    started_test = @test_passage.created_at

    DateTime.now <= started_test + seconds
  end

end
