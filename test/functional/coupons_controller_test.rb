require 'test_helper'

class CouponsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coupons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupon" do
    assert_difference('Coupon.count') do
      post :create, :coupon => { }
    end

    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should show coupon" do
    get :show, :id => coupons(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => coupons(:one).id
    assert_response :success
  end

  test "should update coupon" do
    put :update, :id => coupons(:one).id, :coupon => { }
    assert_redirected_to coupon_path(assigns(:coupon))
  end

  test "should destroy coupon" do
    assert_difference('Coupon.count', -1) do
      delete :destroy, :id => coupons(:one).id
    end

    assert_redirected_to coupons_path
  end
end
