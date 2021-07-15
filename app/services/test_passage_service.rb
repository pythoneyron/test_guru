class TestPassageService
  TEST_LEVEL = 3
  FILTER_BY_BACKEND = 'Backend'

  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
  end

  def call_set_badges
    # Обходим все бэйджи и вызываем одноименные методы
    Badge.all.each do |badge|
      @user.badges << badge if send("#{badge.rule}_award?", badge)
    end
  end

  private

  def success_backend_award?(badge)
    tests_backend = Test.by_category_name(FILTER_BY_BACKEND).count

    tests_backend_user = @user.tests.success_tests.distinct.count

    true if tests_backend == tests_backend_user && !@user.badges.include?(badge)
  end

  def success_on_first_try_award?(badge)
    user = @test_passage.user
    test = @test_passage.test

    tests_passages = TestPassage.where(user_id: user.id, test_id: test.id)

    true if tests_passages.count == 1
  end

  def success_certain_level_award?(badge)
    tests_by_level = Test.where(level: TEST_LEVEL).count
    correct_tests_by_level = @user.tests.success_tests.where(level: TEST_LEVEL).distinct.count

    true if tests_by_level == correct_tests_by_level
  end
end