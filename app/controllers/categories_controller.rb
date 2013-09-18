class CategoriesController < ApplicationController

  def find
    @tag = Category.find_by_name(params[:find].downcase)
    if @tag
      redirect_to @tag
    else
      flash[:error] = "Nothing with '#{params[:find]}'. Try one of these"
      redirect_to categories_url
    end
  end

  def index
    @categories = Category.order(:name)
    respond_to do |format|
      format.html
      format.json { render json: @categories.tokens(params[:q]) }
    end
  end

  def show
    @category = Category.find(params[:id]).name
    @entries = Category.find(params[:id]).entries
    @designs = Category.find(params[:id]).designs
  end
  
end
