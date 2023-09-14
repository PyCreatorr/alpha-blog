require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username:"John Doe", email: "test@test.com", password: '123', admin: true)
    sign_in_as(@admin_user)
  end

  test "get new category form and create category" do
    #sign_in_as(@admin_user)
    get "/categories/new"
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_path, params: { category: { name: "Sports" } }

      assert_response :redirect
    end

    follow_redirect!
    assert_response :success

    assert_match "Sports", response.body
  end


  test "get new category form and reject invalid category submition" do
    #sign_in_as(@admin_user)
    get "/categories/new"
    assert_response :success

    # category would be not creted
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "" } }
    end

    # search on the redirected page word "errors"
    assert_match " errors ", response.body

    # select div.alert & h4.alert-heading as error messages
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end
