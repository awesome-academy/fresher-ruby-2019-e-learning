class CoursesController < ApplicationController
  before_action :logged_in_user

  def index
    if params[:search].present?
      @courses = Course.search(params[:search]).page(params[:page])
        .per Settings.courses.paging.page_number
    else
      @courses = Course.sort_by_created_at.page(params[:page])
        .per Settings.courses.paging.page_number
    end
  end
end
