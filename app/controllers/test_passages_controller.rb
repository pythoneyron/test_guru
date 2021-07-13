class TestPassagesController < ApplicationController
  TEST_LEVEL = 3

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[ show result update gist ]

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
      set_badges(@test_passage)
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def set_badges(test_passage)
    # Бэйдж после успешного прохождения всех тестов из категории Backend
    success_backend

    # Бэйдж после успешного прохождения теста с первой попытки
    success_on_first_try(test_passage)

    # Бэйдж после успешного прохождения всех тестов определённого уровня
    success_certain_level
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def success_backend
    category_id_backend = Category.find_by(title: 'Backend').id
    tests_backend = Test.where(category_id: category_id_backend).count

    tests_backend_user = current_user.tests.correct_questions_more_zero.success_tests.distinct.count

    if tests_backend == tests_backend_user
      badge_success_backend = Badge.find_by(rule: 'success_backend')
      current_user.badges.push(badge_success_backend) unless current_user.badges.include?(badge_success_backend)
    end
  end

  def success_on_first_try(test_passage)
    user = test_passage.user
    test = test_passage.test

    badge_success_on_first_try = Badge.find_by(rule: 'success_on_first_try')
    tests_passages = TestPassage.where(user_id: user.id, test_id: test.id)

    current_user.badges.push(badge_success_on_first_try) if tests_passages.count == 1 and test_passages.first.success?
  end

  def success_certain_level
    tests_by_level = Test.where(level: TEST_LEVEL).count
    correct_tests_by_level = current_user.tests.correct_questions_more_zero.success_tests.where(level: TEST_LEVEL).distinct.count

    if tests_by_level == correct_tests_by_level
      badge_certain_level = Badge.find_by(rule: 'success_certain_level')
      current_user.badges.push(badge_certain_level)
    end
  end

end
