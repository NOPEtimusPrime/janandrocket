class AddIsPublishedToEpisodes < ActiveRecord::Migration
  def change
  	add_column :episodes, :is_published, :bool
  end
end
