require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @test = products(:one)  # From products.yml
    @new = {
      title: 'Lorem Ipsum',
      description: 'Wibbies are fun!',
      image_url: 'lorem.jpg',
      price: 19.95 
    }
    @update = {
      title: 'Lorem Ipsum',
      description: 'Wibbies are fun!',
      image_url: 'lorem.jpg',
      price: 19.95 
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    # Make sure @products instance variable was set in ProductController's index
    assert_not_nil assigns(:products)

    # Number of books (rows)
    assert_select '#main tr', minimum: 3
    assert_select 'dt', 'Programming Ruby 1.9'
  end

  test "should get new" do
    get :new
    assert_response :success

    assert_not_nil assigns(:product)
  end

  test "should create product" do
    assert_difference('Product.count') do
      #post :create, product: { description: @product.description, image_url: @product.image_url, 
      #price: @product.price, title: @product.title }
      post :create, product: @new
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @test
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @test
    assert_response :success
  end

  test "should update product" do
    #patch :update, id: @product, product: { description: @product.description, image_url: @product.image_url, 
    #price: @product.price, title: @product.title }
    patch :update, id: @test, product: @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @test
    end

    assert_redirected_to products_path
  end
end
