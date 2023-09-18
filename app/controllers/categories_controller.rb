class CategoriesController < ApplicationController
    # require_admin comes from application_controller
    before_action :require_admin, except: [:index, :show] 

    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = "Category was successfully created ;)"
            redirect_to category_url(@category)

            # or just this redirect_to @category
        else 
            render 'new', status: :unprocessable_entity
        end
    end

    def index
        #@categories = Category.all
        @categories = Category.paginate(page: params[:page], per_page: 3)
    end

    def new
        @category = Category.new
    end

    def show
        #binding.break
        @category = Category.find(params[:id])
        @articles = @category.articles.paginate(page: params[:page], per_page: 3)
    end

    private
    def category_params
        params.require(:category).permit(:name)
    end
   
    def require_admin
        # If user is not logged in, this function just exit
        if !(logged_in? && current_user.admin?)
            flash[:danger] = "Only admins can perform this action"
            redirect_to categories_path
        end
    end 

end