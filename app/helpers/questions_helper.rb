module QuestionsHelper
  def question_header(question)
    if question.new_record?
      'Создать вопрос'
    else
      'Редактировать вопрос'
    end
  end
end
