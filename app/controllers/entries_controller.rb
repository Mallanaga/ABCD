class EntriesController < ApplicationController
  before_filter :signed_in_user,     only: [:create, :destroy, :update]
  before_filter :check_for_cancel,   only: [:create, :update]
  before_filter :correct_user,       only: [:edit, :update, :destroy]

  def create
    @entry = current_user.entries.build(params[:entry])
    if @entry.save
      #@entry.first_image
      flash[:success] = 'Blog entry created'
      redirect_to entries_path
    else
      render 'entries/new'
    end
  rescue Timeout::Error
    flash[:alert] = "#{$!}"
    render 'entries/new'
  end

  def destroy
    Entry.find(params[:id]).destroy
    flash[:success] = 'Blog entry deleted'
    redirect_to entries_path
  end

  def edit
    @title = 'Edit Blog'
    @entry = Entry.find(params[:id])
  end

  def feed
    # this will be the name of the feed displayed on a feed reader
    @title = 'Alphabetic Design. Ideas, as simple as ABC all the way to XYZ.'
    # the blog entries
    @entries = Entry.limit(10)
    @designs = Design.limit(5)
    # this will be the feed's update timestamp
    @updated = @entries.first.updated_at unless @entries.empty?

    respond_to do |format|
      format.html
      format.atom { render layout: false }
      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to feed_path, status: :moved_permanently }
    end
  end

  def index
    @title = 'Blog'
    @entries = Entry.page(params[:page]).per(10)
  end

  def new
    @title = 'New Blog'
    @entry = Entry.new
  end

  def show
    @entry = Entry.find(params[:id])
    @categories = @entry.categories
    tags = @categories.map {|c| c.name}
    @related = Entry.joins(:categories).where('categories.name' => tags).reject {|d| d.id == @entry.id}.uniq
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(params[:entry])
      #@entry.first_image
      flash[:success] = 'Blog entry updated'
      redirect_to @entry
    else
      render 'entries/edit'
    end
  rescue Timeout::Error
    flash[:alert] = "#{$!}"
    render 'entries/edit'
  end

  private

    def check_for_cancel
      if params[:commit] == 'Cancel'
        redirect_to entries_path
      end
    end

    def correct_user
      @entry = current_user.entries.find_by_id(params[:id])
      redirect_to root_url if @entry.nil?
    end

end
