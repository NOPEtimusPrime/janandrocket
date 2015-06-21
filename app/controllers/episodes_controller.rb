class EpisodesController < Comfy::Cms::ContentController
	helper :Episodes

def index
	@episodes = Episode.order("id DESC")
	render :cms_layout => 'page'
end

def show
	@episode = Episode.find(params[:id])
	@id = @episode.id
	render :cms_layout => 'episode'
end

end