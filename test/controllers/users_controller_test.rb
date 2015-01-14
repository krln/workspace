require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should redirect index when not signed in" do
    get :index
    assert_redirected_to signin_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not signed in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to signin_url
  end

  test "should redirect update when not signed in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to signin_url
  end

  test "should redirect edit when signed in as wrong user" do
    sign_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when signed in as wrong user" do
    sign_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not signed in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to signin_url
  end

  test "should redirect destroy when signed in as a non-admin" do
    sign_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end
end
