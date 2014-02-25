require 'test_helper'

class WaitlistApplicationsControllerTest < ActionController::TestCase
  setup do
    @waitlist_application = waitlist_applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:waitlist_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create waitlist_application" do
    assert_difference('WaitlistApplication.count') do
      post :create, waitlist_application: { guardian_id: @waitlist_application.guardian_id }
    end

    assert_redirected_to waitlist_application_path(assigns(:waitlist_application))
  end

  test "should show waitlist_application" do
    get :show, id: @waitlist_application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @waitlist_application
    assert_response :success
  end

  test "should update waitlist_application" do
    patch :update, id: @waitlist_application, waitlist_application: { guardian_id: @waitlist_application.guardian_id }
    assert_redirected_to waitlist_application_path(assigns(:waitlist_application))
  end

  test "should destroy waitlist_application" do
    assert_difference('WaitlistApplication.count', -1) do
      delete :destroy, id: @waitlist_application
    end

    assert_redirected_to waitlist_applications_path
  end
end
