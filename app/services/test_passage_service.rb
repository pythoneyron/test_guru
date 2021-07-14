class TestPassageService
  TEST_LEVEL = 3

  def initialize(test_passage, current_user)
    @test_passage = test_passage
    @current_user = current_user
  end

  def call_set_badges
    # Бэйдж после успешного прохождения всех тестов из категории Backend
    success_backend

    # Бэйдж после успешного прохождения теста с первой попытки
    success_on_first_try if @test_passage.success?

    # Бэйдж после успешного прохождения всех тестов определённого уровня
    success_certain_level
  end

  private

  def success_backend
    tests_backend = Test.by_category_name('Backend').count

    tests_backend_user = @current_user.tests.success_tests.distinct.count

    if tests_backend == tests_backend_user
      badge_success_backend = Badge.find_by(rule: 'success_backend')
      @current_user.badges.push(badge_success_backend) unless @current_user.badges.include?(badge_success_backend)
    end
  end

  def success_on_first_try
    user = @test_passage.user
    test = @test_passage.test

    badge_success_on_first_try = Badge.find_by(rule: 'success_on_first_try')
    tests_passages = TestPassage.where(user_id: user.id, test_id: test.id)

    @current_user.badges.push(badge_success_on_first_try) if tests_passages.count == 1
  end

  def success_certain_level
    tests_by_level = Test.where(level: TEST_LEVEL).count
    correct_tests_by_level = @current_user.tests.success_tests.where(level: TEST_LEVEL).distinct.count

    if tests_by_level == correct_tests_by_level
      badge_certain_level = Badge.find_by(rule: 'success_certain_level')
      @current_user.badges.push(badge_certain_level)
    end
  end
end