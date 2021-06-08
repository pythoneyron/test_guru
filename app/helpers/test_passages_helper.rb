module TestPassagesHelper
  def percentage_result(test_passage)
    count_questions = test_passage.test.questions.count
    count_current_answers = test_passage.correct_questions
    100.0 / count_questions * count_current_answers
  end
end
