class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[ show result update gist check_timer ]

  def show
  end

  def result
  end

  def check_timer
    if @test_passage.test
      timer = @test_passage.test.timer
      started_test_time = @test_passage.created_at

      date_time = DateTime.parse(timer.to_s(:time))
      seconds = date_time.hour * 3600 + date_time.min * 60
      end_test_time = started_test_time + seconds

      if DateTime.now <= end_test_time
        render :json => {:time_left => true}
      else
        render :json => {:time_left => false}
      end
    end
  end

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

    if @test_passage.completed?
      @test_passage.update(success: true) if @test_passage.success?

      TestsMailer.completed_test(@test_passage).deliver_now

      TestPassageService.new(@test_passage).call_set_badges if @test_passage.success?

      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

end
