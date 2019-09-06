class CoursesController < ApplicationController
  before_action :logged_in_user

  def index
    @courses = Course.order(created_at: :desc).page(params[:page])
      .per Settings.courses.paging.page_number
  end
end
