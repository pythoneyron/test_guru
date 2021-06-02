class TestsController < ApplicationController

  before_action :find_test, only: %i[show]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    @tests = Test.all
  end

  def show
    render plain: @test.inspect
  end

  def create
    test = Test.new(test_params)

    if test.save
      redirect_to test
    else
      render plain: "Тест не создан!\n #{test.errors.messages}"
    end
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end

  def rescue_with_test_not_found
    render plain: 'Test was not found'
  end
end