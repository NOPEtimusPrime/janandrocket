module EpisodesHelper

	def nav_arrows(id)
		back = id - 1
		forward = id + 1
		html = ''

		html << %Q{<span class="back">}
		if back > 0
			html << link_to("", Episode.find(back), {:class => "back"})
		else 
			html << link_to("", "", {:class => "oldest"})
		end
		html << %Q{</span>}
		html << %Q{<span class="forward">}
		unless forward > Episode.last.id
			html << link_to("", Episode.find(forward), {:class => "forward"})
		else
			html << link_to("", "", {:class => "newest"})
		end
		html << %Q{</span>}
		return html.html_safe
	end

	def show_current
		@episode = Episode.where(:is_published => 1).last
		@id = @episode.id
		render 'episodes/current'
	end
end