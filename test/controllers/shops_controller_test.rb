require 'test_helper'

class ShopsControllerTest < ActionController::TestCase
  setup do
    @shop = shops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop" do
    assert_difference('Shop.count') do
      post :create, shop: { adress: @shop.adress, book_id: @shop.book_id, close_time: @shop.close_time, latitude: @shop.latitude, longitude: @shop.longitude, memo: @shop.memo, name: @shop.name, open_time: @shop.open_time }
    end

    assert_redirected_to shop_path(assigns(:shop))
  end

  test "should show shop" do
    get :show, id: @shop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop
    assert_response :success
  end

  test "should update shop" do
    patch :update, id: @shop, shop: { adress: @shop.adress, book_id: @shop.book_id, close_time: @shop.close_time, latitude: @shop.latitude, longitude: @shop.longitude, memo: @shop.memo, name: @shop.name, open_time: @shop.open_time }
    assert_redirected_to shop_path(assigns(:shop))
  end

  test "should destroy shop" do
    assert_difference('Shop.count', -1) do
      delete :destroy, id: @shop
    end

    assert_redirected_to shops_path
  end
end
