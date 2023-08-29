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



    respond_to do |format|
      if @article.save
        #flash[:notice] = "Article was successfully created!"
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

end