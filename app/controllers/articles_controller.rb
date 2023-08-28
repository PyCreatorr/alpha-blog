class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
  end
  def index
    @articles = Article.all
  end

  #@article = Article.new(params)
  # visualise the created article as the plain text
  def create
    #render plain: params[:article]
    @article = Article.new(params.require(:article).permit(:title, :description))
    #render plain: @article.inspect
    @article.save

    # redirect to the page with created article and set the id, that is just created
    # use route Prefix  | article 
    # Verb              | GET
    # URI               | /articles/:id(.:format)
    # Controller#Action | articles#show
    # redirect_to -> prefix_path(@article)
    #redirect_to article_path(@article)
    #Or shorter 
    
    redirect_to @article

  end

  def new

  end

end