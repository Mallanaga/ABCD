class DesignsController < ApplicationController

  before_filter :check_for_cancel,   only: [:create, :update]
  before_filter :signed_in_user,     only: [:create, :destroy, :update]
  
  def create
    @design = Design.new(params[:design])
    if @design.save
      #@design.first_image
      flash[:success] = "Design created"
      redirect_to designs_url
    else
      render 'designs/new'
    end
  rescue Timeout::Error
    flash[:alert] = "#{$!}"
    render 'designs/new'
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
      url: "#{request.host_with_port}/designs"
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
    #@doc = Nokogiri::HTML(open(design_url(@design)))
    #images = @doc.css('.well img') ? @doc.css('.well img').map{ |i| i['src'] } : []
    set_meta_tags og: {
      title: @design.name,
      type: 'article',
      url: design_url(@design),
      image: @design.photo_url, #will need to be images array eventually
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
    if @design.update_attributes(params[:design])
      #@design.first_image
      flash[:success] = "Design updated"
      redirect_to @design
    else
      render 'designs/edit'
    end
  rescue Timeout::Error
    flash[:alert] = "#{$!}"
    render 'designs/edit'
  end

  private

    def check_for_cancel
      if params[:commit] == "Cancel"
        redirect_to designs_url
      end
    end
  
end
