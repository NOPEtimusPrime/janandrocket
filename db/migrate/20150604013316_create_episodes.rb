class CreateEpisodes < ActiveRecord::Migration

  def change
    create_table :episodes do |t|
      t.string :title
      t.text :content
      t.timestamps
    end
  end

end