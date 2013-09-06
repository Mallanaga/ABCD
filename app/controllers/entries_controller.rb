class EntriesController < ApplicationController
  before_filter :signed_in_user,     only: [:create, :destroy, :feed]
  before_filter :check_for_cancel,   only: [:create, :update]
  before_filter :correct_user,       only: [:edit, :update, :destroy]

  def create
    @entry = current_user.entrys.build(params[:entry])
    if @entry.save
      flash[:success] = "Entry created!"
      redirect_to entries_path
    else
      flash[:error] = "Something went wrong there... try again."
    end
  end

  def destroy
    Entry.find(params[:id]).destroy
    flash[:success] = "Entry deleted!"
    redirect_to entries_path
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def feed
    # this will be the name of the feed displayed on a feed reader
    @title = "ABCD"
    # the blog entries
    @entries = Entry.limit(10)
    # this will be the feed's update timestamp
    @updated = @entries.first.updated_at unless @entries.empty?

    respond_to do |format|
      format.html
      format.atom { render layout: false }
      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to entries_path(format: :atom), status: :moved_permanently }
    end
  end

  def index
    @entries = Entry.all
  end

  def new
    @entry = Entry.new
  end

  def show
    @entry = Entry.find(params[:id])
    @categories = @entry.categories
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(params[:entry])
      flash[:success] = "Entry updated!"
      redirect_to @entry
    else
      flash[:error] = "Something went wrong there... try again."
      render 'entries/edit'
    end
  end

  private

    def check_for_cancel
      if params[:commit] == "Cancel"
        redirect_to entries_path
      end
    end

    def correct_user
      @entry = current_user.entries.find_by_id(params[:id])
      redirect_to root_url if @entry.nil?
    end

end
