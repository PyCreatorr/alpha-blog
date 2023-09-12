class CategoriesController < ApplicationController

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
    end

    def new
        @category = Category.new
    end

    def show
    end

    private
    def category_params
        params.require(:category).permit(:name)
    end

end