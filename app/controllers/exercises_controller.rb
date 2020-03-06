class ExercisesController < ApplicationController
  before_action :logged_in_user
  before_action :load_courses, only: %i(new create)
  before_action :load_exercise, :correct_answers, only: %i(show edit update)

  def index
    @exercises = Exercise.last_exercises.page(params[:page])
      .per Settings.exercises.paging.paging_number
  end
  
  def new
    @exercise = Exercise.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    params[:exercise][:user_id] = current_user.id
    course_id = params[:exercise][:course_id].to_i
    
    ActiveRecord::Base.transaction do 
      @exercise = Exercise.create exercise_params
      ExerciseService.new(@exercise, course_id,
        Settings.exercises.default).create_exercise_detail
    end
    
    respond_to do |format|
      format.html{redirect_to @exercise}
      format.js
    end
    redirect_to exercises_path
  end

  def edit
    byebug
  end

  def update
    if @exercise.update exercise_params
      flash[:danger] = "success"
      ExerciseService.new(@exercise, @exercise.course_id,
        params[:exercise]).result_handle
    else
      flash[:danger] = t ".exercise_fail"
    end
    redirect_to exercises_path
  end

  private

  def exercise_params
    params.require(:exercise).permit Exercise::EXERCISE_PARAMS
  end

  def load_courses
    @courses = Course.sort_by_created_at
  end

  def load_exercise
    @exercise = Exercise.find_by id: params[:id]
    
    if @exercise
      @exercise_details = @exercise.exercise_details
    else
      flash[:danger] = t ".not_found"
      redirect_to exercises_path
    end
  end
  
  def correct_answers
    ExerciseService.new(@exercise, @exercise.course_id,
      Settings.exercises.default).get_correct_answers
  end
end
