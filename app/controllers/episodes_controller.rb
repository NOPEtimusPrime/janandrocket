class EpisodesController < Comfy::Cms::ContentController

def index
	@episodes = Episode.order("id DESC")
end

def show
	@episode = Episode.find(params[:id])
end

end