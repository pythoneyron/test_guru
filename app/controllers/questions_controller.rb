class QuestionsController < ApplicationController

  before_action :find_question, only: %i[show]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = Question.where(test_id: params[:test_id])
  end

  def show
    render plain: @question.inspect
  end

  def show_all
    render plain: Question.all.inspect
  end

  def create
    question = Question.create(question_param)
    redirect_to question
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_back(fallback_location: index)
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_param
    params.require(:question).permit(:body, :test_id)
  end

  def rescue_with_question_not_found
    render plain: 'Question was not found'
  end
end