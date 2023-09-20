require "test_helper"

class SignUpUserTest < ActionDispatch::IntegrationTest
    setup do
        #@user = User.create(username: "John", email: "test@test.com", password: '123')
        #@admin_user = User.create(username:"John Doe", email: "test@test.com", password: '123', admin: true)
        #sign_in_as(@admin_user)
      end

    test "get signup form and post/submit the login data" do
      get "/signup"
      assert_response :success

      assert_difference "User.count", 1 do
        # create new user - send post request with users credentials and then the User.count will growth to 1
        post users_path, params: { user: { username: "John", email: "test@test.com", password: '123' } }
        assert_response :redirect
      end
        follow_redirect!
        assert_response :success
    
        assert_match "Wellcome to Alpha Blog", response.body
        assert_select 'div.alert.alert-success'
    
    end



end