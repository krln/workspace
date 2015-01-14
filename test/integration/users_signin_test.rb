require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "signin with invalid information" do
    get signin_path
    assert_template 'sessions/new'
    post signin_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "signin with valid information followed by signout" do
    get signin_path
    post signin_path, session: { email: @user.email, password: 'password' }
    assert is_signed_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", signin_path, count: 0
    assert_select "a[href=?]", signout_path
    assert_select "a[href=?]", user_path(@user)
    delete signout_path
    assert_not is_signed_in?
    assert_redirected_to root_url
    delete signout_path
    follow_redirect!
    assert_select "a[href=?]", signin_path
    assert_select "a[href=?]", signout_path,     count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

    test "signin with remembering" do
    sign_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "signin without remembering" do
    sign_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
