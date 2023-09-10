class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    #@article = Article.find(params[:id])
  end
  def index
    #@articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  #@article = Article.new(params)
  # visualise the created article as the plain text

  def create
    #render plain: params[:article]
    @article = Article.new(article_params)
    #render plain: @article.inspect
    #@article.user_id = User.first

    #add user to the article
    # @article.user = User.first
    @article.user = current_user
    
    respond_to do |format|
      if @article.save
        #flash[:notice] = "Article was successfully created!"
        #binding.break
        flash[:success] = "Article was successfully created ;)"
        format.html { redirect_to article_url(@article)}
        format.html {redirect_to @article }
        #format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end

    # if @article.save
    #   redirect_to @article
    # else 
    #   render :new
    # end
    # redirect to the page with created article and set the id, that is just created
    # use route Prefix  | article 
    # Verb              | GET
    # URI               | /articles/:id(.:format)
    # Controller#Action | articles#show
    # redirect_to -> prefix_path(@article)
    #redirect_to article_path(@article)
    #Or shorter 

  end

  def new
    @article = Article.new

  end

  def edit
    #byebug
    #binding.break
    #@article = Article.find(params[:id])
  end

  def update
    #binding.break
    #@article = Article.find(params[:id])

    respond_to do |format|

      if @article.update(article_params)
        #flash[:notice] = "Article was successfully created!"
        flash[:success] = "Article was updated successfully!"
        format.html { redirect_to article_url(@article)}
        #format.html {redirect_to @article }
        #format.json { render :show, status: :created, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        #format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    #@article = Article.find(params[:id])

    respond_to do |format|
      if @article.destroy
        # articles_path -> Route 1  Prefix : articles + _path
        flash[:success] = "Article was updated successfully!"
        format.html { redirect_to articles_path }
      end

    end


  end


  private
  
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if (current_user != @article.user) && !current_user.admin?
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to @article
    
    end
  end

end