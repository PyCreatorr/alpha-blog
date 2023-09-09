class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :show, :update]
    before_action :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update]

    def index
      #@users = User.all
      @users = User.paginate(page: params[:page], per_page: 3)
    end
  
    def new
      @user = User.new
    end

    def edit
      #binding.break
      #@user = User.find(params[:id])
    end

    def show
      #@user = User.find(params[:id])
      
      # Define @articles from @users, to use the _articles.html.erb partition:
      #@articles = @user.articles
      @articles = @user.articles.paginate(page: params[:page], per_page: 3)
    end

  # This action uses POST parameters. They are most likely coming
  # from an HTML form that the user has submitted. The URL for
  # this RESTful request will be "/users", and the data will be
  # sent as part of the request body.

  def create
    # binding.break
    # @user = User.create(params[:user])
    @user = User.create(user_params)

    respond_to do |format|
      if @user.save
          session[:user_id] = @user.id
          format.html { redirect_to articles_path, notice: "Wellcome to Alpha Blog #{@user.username}, you have signed up!"}
          format.html {redirect_to @article }
          # redirect_to articles_path, notice: "Wellcome to Alpha Blog #{@user.username}, you have signed up!"
          else
            # This line overrides the default rendering behavior, which
            # would have been to render the "create" view.
            format.html { render :new, status: :unprocessable_entity }
            #render "new"
          end
      end
    end

  def update
    #binding.break
    #@user = User.find(params[:id])

    respond_to do |format|
      if @user.update(user_params)
        #binding.break
          format.html { redirect_to user_path, notice: "User: #{@user.username} was updated successfully!"}
          #format.html {redirect_to @article }
          # redirect_to articles_path, notice: "Wellcome to Alpha Blog #{@user.username}, you have signed up!"
      else
          # This line overrides the default rendering behavior, which
          # would have been to render the "create" view.
          format.html { render :edit, status: :unprocessable_entity }
          #render "new"
      end
  end

  end



  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user
        flash[:notice] = "You can only edit your own account"
        redirect_to @user
      end
    end

    
end