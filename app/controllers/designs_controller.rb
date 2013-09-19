class DesignsController < ApplicationController
  before_filter :check_for_cancel,   only: [:create, :update]
  before_filter :signed_in_user,     only: [:create, :destroy, :update]
  
  def create
    @design = Design.new(params[:design])
    if @design.save
      flash[:success] = "Design created."
      redirect_to designs_url
    else
      render 'designs/new'
    end
  end

  def destroy
    Design.find(params[:id]).destroy
    flash[:success] = "Design destroyed."
    redirect_to designs_url
  end

  def edit
    @title = 'Edit design'
    @design = Design.find(params[:id])
  end
  
  def index
    @title = 'Designs'
    @designs = Design.page(params[:page]).per(10)
  end

  def new
    @title = 'New design'
    @design = Design.new
  end

  def show
    @design = Design.find(params[:id])
    @categories = @design.categories
  end

  def update
    if @design.update_attributes(params[:design])
      flash[:success] = "Design updated."
      redirect_to @design
    else
      render 'designs/edit'
    end
  end

  private

    def check_for_cancel
      if params[:commit] == "Cancel"
        redirect_to designs_url
      end
    end
  
end
