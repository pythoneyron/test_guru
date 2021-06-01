class QuestionsController < ApplicationController

  before_action :find_question, only: %i[show]
  before_action :find_test, only: %i[index create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
  end

  def show
    render plain: @question.inspect
  end

  def create
    question = @test.questions.new(questions_params)

    if question.save
      redirect_to question
    else
      render plain: 'Вопрос не создан!'
    end
  end

  def destroy
    question = find_question
    question.destroy
    redirect_back(fallback_location: '/')
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def questions_params
    params.require(:question).permit(:body)
  end

  def rescue_with_question_not_found
    render plain: 'Question was not found'
  end
end
