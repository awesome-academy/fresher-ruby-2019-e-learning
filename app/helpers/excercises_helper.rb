module ExcercisesHelper
  def date_convert date
    date.strftime("%B %e, %Y at %I:%M %p")
  end
end
