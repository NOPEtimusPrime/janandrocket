class Admin::EpisodesController < Comfy::Admin::Cms::BaseController

  before_action :build_episode,  :only => [:new, :create]
  before_action :load_episode,   :only => [:show, :edit, :update, :destroy]

  def index
    @episodes = Episode.order("id DESC").page(params[:page])
  end

  def show
    render
  end

  def new
    render
  end

  def edit
    render
  end

  def create
    @episode.save!
    flash[:success] = 'Episode created'
    redirect_to :action => :show, :id => @episode
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = 'Failed to create Episode'
    render :action => :new
  end

  def update
    @episode.update_attributes!(episode_params)
    flash[:success] = 'Episode updated'
    redirect_to :action => :show, :id => @episode
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = 'Failed to update Episode'
    render :action => :edit
  end

  def destroy
    @episode.destroy
    flash[:success] = 'Episode deleted'
    redirect_to :action => :index
  end

protected

  def build_episode
    @episode = Episode.new(episode_params)
  end

  def load_episode
    @episode = Episode.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Episode not found'
    redirect_to :action => :index
  end

  def episode_params
    params.fetch(:episode, {}).permit(:title, :content, :is_published)
  end
end