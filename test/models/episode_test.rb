require_relative '../test_helper'

class EpisodeTest < ActiveSupport::TestCase

  def test_fixtures_validity
    Episode.all.each do |episode|
      assert episode.valid?, episode.errors.inspect
    end
  end

  def test_validation
    episode = Episode.new
    assert episode.invalid?
  end

  def test_creation
    assert_difference 'Episode.count' do
      Episode.create(
        :title => 'test title',
        :content => 'test content',
      )
    end
  end

end