class StaticPagesController < ApplicationController
  def home
    @courses = Course.order(created_at: :desc).limit Settings.courses.number
  end
end
