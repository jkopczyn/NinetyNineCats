module CatsHelper
  def current_cat
    @cat ||= Cat.find(params[:id])
  end

  def current_user_owns_cat?
    current_cat.user_id == current_user_id
  end
end
