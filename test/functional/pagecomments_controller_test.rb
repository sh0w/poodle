require 'test_helper'

class PagecommentsControllerTest < ActionController::TestCase
  setup do
    @pagecomment = pagecomments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pagecomments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pagecomment" do
    assert_difference('Pagecomment.count') do
      post :create, pagecomment: { content: @pagecomment.content, page_id: @pagecomment.page_id, rating: @pagecomment.rating, user_id: @pagecomment.user_id }
    end

    assert_redirected_to pagecomment_path(assigns(:pagecomment))
  end

  test "should show pagecomment" do
    get :show, id: @pagecomment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pagecomment
    assert_response :success
  end

  test "should update pagecomment" do
    put :update, id: @pagecomment, pagecomment: { content: @pagecomment.content, page_id: @pagecomment.page_id, rating: @pagecomment.rating, user_id: @pagecomment.user_id }
    assert_redirected_to pagecomment_path(assigns(:pagecomment))
  end

  test "should destroy pagecomment" do
    assert_difference('Pagecomment.count', -1) do
      delete :destroy, id: @pagecomment
    end

    assert_redirected_to pagecomments_path
  end
end
