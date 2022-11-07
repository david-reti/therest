class CommentsController < ApplicationController
  before_action :set_comment, only: [ :destroy ]

  # POST /comments or /comments.json
  def create
    @comment = Comment.new comment_params

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.article, notice: t('messages.comment_creation_success') }
      else
        format.html { redirect_to :root, alert: t('messages.comment_creation_error') }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to article_url(@comment.article_id), notice: t('messages.comment_creation_success') }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:article_id, :user_id, :message)
    end
end
