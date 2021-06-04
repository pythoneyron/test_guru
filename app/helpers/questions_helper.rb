module QuestionsHelper
  def question_header(question)
    if question.new_record?
      'Создать вопрос'
    else
      'Редактировать вопрос'
    end
  end

  def this_year
    Date.today.year
  end

  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}"
  end
end
