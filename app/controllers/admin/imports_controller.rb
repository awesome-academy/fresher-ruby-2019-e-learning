class Admin::ImportsController < Admin::BaseController
  def import_words
    Word.import_word params[:file]
    redirect_to admin_words_path, notice: t(".import")
  end
  
  def import_questions
    Question.import_questions params[:file]
    redirect_to admin_words_path, notice: t(".import")
  end
end