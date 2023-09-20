require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
    setup do
        # User must be logged in. 
        #So we create new user and login with user credentials.
        @user = User.create(username: "John", email: "test@test.com", password: '123')
        sign_in_as(@user)
    end

    test "get new article page and then post request with articles params" do
        
        get "/articles/new"
        assert_response :success

        assert_difference "Article.count", 1 do
            post articles_path, params: { 
                article: { title: "New article", description: "Article description" }, 
                categories: {category_ids: [""] } 
            }
            assert_response :redirect
        end

        follow_redirect!
        assert_response :success
            
        assert_match "New article", response.body
        assert_select 'div.alert.alert-success'

    end

end