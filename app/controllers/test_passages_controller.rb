class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[ show result update gist ]

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

    unless @test_passage.time_is_left?
      send_email_set_badge_and_result
      return redirect_to result_test_passage_path(@test_passage), alert: 'Время вышло, тест завершен.'
    end

    if @test_passage.completed?
      send_email_set_badge_and_result
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def send_email_set_badge_and_result
    @test_passage.update(success: true) if @test_passage.success?

    TestsMailer.completed_test(@test_passage).deliver_now
    TestPassageService.new(@test_passage).call_set_badges if @test_passage.success?
  end

end
