require_relative '../test_helper'

class EpisodesControllerTest < ActionController::TestCase

  def setup
    Comfy::Cms::Site.create(:label => "test", :identifier => "test")
    Comfy::Cms::Layout.create(:site_id => 1, :app_layout => "page", :label => "page", :identifier => "page")
    Comfy::Cms::Layout.create(:site_id => 1, :app_layout => "episode", :label => "episode", :identifier => "episode")
    @episode = episodes(:default)
  end

  def test_get_index
    get :index
    assert_response :success
    assert assigns(:episodes)
    assert_template :index
  end

  def test_get_show
    get :show, :id => @episode
    assert assigns(:episode)
    assert_template :show
  end

  def test_get_show_failure
    get :show, :id => 'invalid'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Episode not found', flash[:danger]
  end

end