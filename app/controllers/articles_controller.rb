class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  def show
    #@article = Article.find(params[:id])
  end
  def index
    @articles = Article.all
  end

  #@article = Article.new(params)
  # visualise the created article as the plain text

  def create
    #render plain: params[:article]
    @article = Article.new(article_params)
    #render plain: @article.inspect
    #@article.user_id = User.first

    #add user to the article
    @article.user = User.first
    
    respond_to do |format|
      if @article.save
        #flash[:notice] = "Article was successfully created!"
        #binding.break

        format.html { redirect_to article_url(@article), notice: "Article was successfully created ;)" }
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
        format.html { redirect_to article_url(@article), notice: "Article was updated successfully!" }
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
        format.html { redirect_to articles_path, notice: "Article was updated successfully!" }
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

end