class Admin::QuestionsController < Admin::BaseController

  before_action :find_question, only: %i[show destroy edit update]
  before_action :find_test, only: %i[create new]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def new
    @question = @test.questions.new
  end

  def create
    @question = @test.questions.new(questions_params)

    if @question.save
      redirect_to admin_test_path(@test)
    else
      render new
    end
  end

  def update
    if @question.update(questions_params)
      redirect_to @question
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_question_path
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
