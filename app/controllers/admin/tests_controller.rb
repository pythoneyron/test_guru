class Admin::TestsController < Admin::BaseController

  before_action :set_tests, only: %i[index update_inline]
  before_action :find_test, only: %i[show destroy edit update start update_inline]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index

  end

  def create
    @test = current_user.author_tests.build(test_params)

    if @test.save
      redirect_to admin_test_path(@test), notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to admin_test_path(@test)
    else
      render :new
    end
  end

  def new
    @test = Test.new
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def set_tests
    @tests = Test.all
  end

  def test_params
    params.require(:test).permit(:title, :level, :timer, :category_id)
  end

  def rescue_with_test_not_found
    render plain: 'Test was not found'
  end
end