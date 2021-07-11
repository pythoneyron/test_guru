class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[ show result update gist ]

  def show

  end

  def result

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
      TestsMailer.completed_test(@test_passage).deliver_now
      current_user.badges.push(check_and_select_badge)
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def check_and_select_badge
    #TODO Переделать нахрен
    category_id_backend = Category.find_by(title: 'Backend').id
    tests_backend = Test.find_by(category_id: category_id_backend)
    tests_backend_user = current_user.tests.find_by(category_id: category_id_backend)

    if tests_backend == tests_backend_user
      Badge.find_by(rule: 'success_backend')
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

end
