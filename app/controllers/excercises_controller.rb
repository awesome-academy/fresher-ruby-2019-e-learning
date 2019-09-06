class ExcercisesController < ApplicationController
  before_action :logged_in_user
  before_action :load_courses, only: %i(new create)
  before_action :load_excercise, only: %i(edit update show)

  def index
    @excercises = current_user.excercises.order(created_at: :desc)
  end
  
  def new
    @excercise = Excercise.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    params[:excercise][:user_id] = current_user.id
    ActiveRecord::Base.transaction do
      @excercise = Excercise.create! excercise_params
      raise ActiveRecord::Rollback unless @excercise.valid?
      excercise_detail @excercise
    end
    respond_to do |format|
      format.html{redirect_to @excercise}
      format.js
    end
    redirect_to excercises_path
  end

  def update
  end

  private

  def excercise_params
    params.require(:excercise).permit Excercise::EXCERCISE_PARAMS
  end

  def excercise_detail excercise
    load_questions params[:excercise][:course_id]
    @questions.each do |question|
      ExcerciseDetail.create(excercise_id: excercise.id,
        question_id: question.id)
    end
  end

  def load_courses
    @courses = Course.order(created_at: :desc)
  end

  def load_excercise
    @excercise = Excercise.find_by id: params[:id]
    
    if @excercise.present?
      @excercise_detail = @excercise.excercise_details
    end
    
    return if @excercise
    flash[:danger] = t ".not_found"
    redirect_to courses_path
  end
end
