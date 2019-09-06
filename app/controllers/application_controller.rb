class ApplicationController < ActionController::Base
  include SessionsHelper

  def load_questions course_id
    rand_question = Question.load_questions_by_course(course_id).order("RAND()")
    @questions = rand_question.limit Settings.excercises.random_number
  end

  private

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".please_login"
    redirect_to login_url
  end
end
