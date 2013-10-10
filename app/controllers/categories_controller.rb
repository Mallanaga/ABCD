class CategoriesController < ApplicationController

  def find
    @tag = Rails.env.development? ? Category.where("LOWER(name) LIKE ?", "%#{params[:find]}%")[0] : Category.where("LOWER(name) ILIKE ?", "%#{params[:find]}%")[0]
    if @tag
      redirect_to @tag
    else
      flash[:notice] = "Nothing with '#{params[:find]}'. Try one of these"
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
    @category = Category.find(params[:id])
    @entries = Category.find(params[:id]).entries
    @designs = Category.find(params[:id]).designs
  end
  
end
