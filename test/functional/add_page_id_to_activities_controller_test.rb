require 'test_helper'

class AddPageIdToActivitiesControllerTest < ActionController::TestCase
  setup do
    @add_page_id_to_activity = add_page_id_to_activities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:add_page_id_to_activities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create add_page_id_to_activity" do
    assert_difference('AddPageIdToActivity.count') do
      post :create, add_page_id_to_activity: { page_id: @add_page_id_to_activity.page_id }
    end

    assert_redirected_to add_page_id_to_activity_path(assigns(:add_page_id_to_activity))
  end

  test "should show add_page_id_to_activity" do
    get :show, id: @add_page_id_to_activity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @add_page_id_to_activity
    assert_response :success
  end

  test "should update add_page_id_to_activity" do
    put :update, id: @add_page_id_to_activity, add_page_id_to_activity: { page_id: @add_page_id_to_activity.page_id }
    assert_redirected_to add_page_id_to_activity_path(assigns(:add_page_id_to_activity))
  end

  test "should destroy add_page_id_to_activity" do
    assert_difference('AddPageIdToActivity.count', -1) do
      delete :destroy, id: @add_page_id_to_activity
    end

    assert_redirected_to add_page_id_to_activities_path
  end
end
