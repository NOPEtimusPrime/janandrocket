require_relative '../../test_helper'

class Admin::EpisodesControllerTest < ActionController::TestCase

  def setup
    @request.env['HTTP_AUTHORIZATION'] = "Basic #{Base64.encode64('username:password')}"
    Comfy::Cms::Site.create(:label => "test", :identifier => "test")
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
    assert_response :success
    assert assigns(:episode)
    assert_template :show
  end

  def test_get_show_failure
    get :show, :id => 'invalid'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Episode not found', flash[:danger]
  end

  def test_get_new
    get :new
    assert_response :success
    assert assigns(:episode)
    assert_template :new
    assert_select "form[action='/admin/episodes']"
  end

  def test_get_edit
    get :edit, :id => @episode
    assert_response :success
    assert assigns(:episode)
    assert_template :edit
    assert_select "form[action='/admin/episodes/#{@episode.id}']"
  end

  def test_creation
    assert_difference 'Episode.count' do
      post :create, :episode => {
        :title => 'test title',
        :content => 'test content',
      }
      episode = Episode.last
      assert_response :redirect
      assert_redirected_to :action => :show, :id => episode
      assert_equal 'Episode created', flash[:success]
    end
  end

  def test_creation_failure
    assert_no_difference 'Episode.count' do
      post :create, :episode => { }
      assert_response :success
      assert_template :new
      assert_equal 'Failed to create Episode', flash[:danger]
    end
  end

  def test_update
    put :update, :id => @episode, :episode => {
      :title => 'Updated'
    }
    assert_response :redirect
    assert_redirected_to :action => :show, :id => @episode
    assert_equal 'Episode updated', flash[:success]
    @episode.reload
    assert_equal 'Updated', @episode.title
  end

  def test_update_failure
    put :update, :id => @episode, :episode => {
      :title => ''
    }
    assert_response :success
    assert_template :edit
    assert_equal 'Failed to update Episode', flash[:danger]
    @episode.reload
    refute_equal '', @episode.title
  end

  def test_destroy
    assert_difference 'Episode.count', -1 do
      delete :destroy, :id => @episode
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Episode deleted', flash[:success]
    end
  end
end