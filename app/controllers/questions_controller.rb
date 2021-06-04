class QuestionsController < ApplicationController

  before_action :find_question, only: %i[show destroy]
  before_action :find_test, only: %i[index create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
  end

  def new
    @question = Question.new(test_id: params[:test_id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = @test.questions.new(questions_params)

    if @question.save
      redirect_to @test
    else
      render new
    end
  end

  def destroy
    @question.destroy
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
