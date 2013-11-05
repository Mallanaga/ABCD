class DesignsController < ApplicationController
  before_filter :signed_in_user,     only: [:create, :destroy, :update]
  before_filter :check_for_cancel,   only: [:create, :update]
  
  def create
    params[:design][:photo_url] = Nokogiri::HTML(params[:design][:content]).css('img').map{ |i| i['src']}[0]
    @design = Design.new(params[:design])
    if @design.save
      flash[:success] = "Design created"
      redirect_to designs_url
    else
      render 'designs/new'
    end
  end

  def destroy
    Design.find(params[:id]).destroy
    flash[:success] = "Design deleted"
    redirect_to designs_url
  end

  def edit
    @title = 'Edit Design'
    @design = Design.find(params[:id])
  end
  
  def index
    @tags = %w[portfolio]
    @title = 'Designs'
    @designs = Design.page(params[:page]).per(10)
    set_meta_tags og: {
      title: 'Alphabetic Designs',
      type: 'website',
      url: designs_url
    }
  end

  def new
    @title = 'New Design'
    @design = Design.new
  end

  def show
    @design = Design.find(params[:id])
    @categories = @design.categories
    @tags = @categories.map {|c| c.name}
    @related = Design.joins(:categories).where('categories.name' => @tags).reject {|d| d.id == @design.id}.uniq
    set_meta_tags og: {
      title: @design.name,
      type: 'article',
      url: design_url(@design),
      image: Nokogiri::HTML(@design.content).css('img').map{ |i| i['src']},
      article: {
        published_time: @design.published_at.to_datetime,
        modified_time: @design.updated_at.to_datetime,
        author: 'Alphabetic Design',
        section: 'Designs',
        tag: @tags
      }
    }
  end

  def update
    @design = Design.find(params[:id])
    params[:design][:photo_url] = Nokogiri::HTML(params[:design][:content]).css('img').map{ |i| i['src']}[0]
    if @design.update_attributes(params[:design])
      flash[:success] = "Design updated"
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
