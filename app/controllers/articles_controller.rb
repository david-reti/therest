class ArticlesController < ApplicationController 
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :set_customization_options

  # GET /articles or /articles.json
  def index
    criterion = search_params.to_h.first
    if criterion
      reviews = criterion[0] != "rating" ? 
        FoodReview.includes(criterion[0]).where(criterion[0] => {id: criterion[1]}).to_a :
        FoodReview.where(criterion[0] => criterion[1]).to_a
      @articles = Article.with_attached_cover_image.where(food_review: reviews)
      @search_criterion = criterion
    else
      @articles = Article.with_attached_cover_image
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new 
    return if signin_required?(desired_path: new_article_path)
    if current_user.has_permission_to :create_article
      @article = current_user.articles.new
      @article.food_review = FoodReview.new
      @article.published_at = DateTime.now
    else
      redirect_to :root, status: :unauthorized, alert: t('permissions.no_permission')
    end
  end

  # GET /articles/1/edit
  def edit
    return if signin_required?(desired_path: edit_article_path)
    redirect_to :root, status: :unauthorized, alert: t('permissions.no_permission') unless current_user.has_permission_to(:edit, @article)
  end

  # POST /articles or /articles.json
  def create
    return if signin_required?(desired_path: new_article_path)
    if current_user.has_permission_to :create_article 
      @article = current_user.articles.new article_params
      respond_to do |format|
        if @article.save
          format.html { redirect_to article_url(@article), notice: t('messages.article_creation_success') }
          format.json { render :show, status: :created, location: @article }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :root, status: :unauthorized, alert: t('permissions.no_permission')
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    return if signin_required?(desired_path: edit_article_path)
    if current_user.has_permission_to(:edit, @article)
      respond_to do |format|
        to_update = article_params
        if to_update[:food_review_select] == "0"
          to_update.delete :food_review_attributes
          @article.food_review.destroy if @article.food_review.present? 
        end
        to_update.delete :food_review_select

        if @article.update(to_update)
          format.html { redirect_to article_url(@article), notice: t('messages.article_update_success') }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, status: :unauthorized, alert: t('permissions.no_permission')
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    return if signin_required?(desired_path: article_path)
    if current_user.has_permission_to(:delete, @article)
      @article.destroy
      respond_to do |format|
        format.html { redirect_to articles_url, notice: t('messages.article_destroy_success') }
        format.json { head :no_content }
      end
    else
      redirect_to :root, status: :unauthorized, alert: t('permissions.no_permission')
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_customization_options
      @default_colours = [['Red Salsa', '#f03a47'], ['Powder Blue', '#c3dfe0'], ['Purple Mountain Majesty', '#8e7dbe'], ['Olivine', '#9dad6f'], ['Black Chocolate', '#0f1108']]
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :cover_image, :primary_colour, :body, :exerpt, :author_id, :published_at,
                                                :food_review_select, food_review_attributes: [ 
                                                :id, :price, :rating, 
                                                :city_id, :cuisine_id ])
    end

    def search_params
      params.permit(:city, :cuisine, :rating)
    end
end
