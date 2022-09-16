json.extract! article, :id, :title, :cover_image, :body, :author_id, :city_id, :cuisine_id, :price, :rating, :created_at, :updated_at
json.url article_url(article, format: :json)
json.cover_image url_for(article.cover_image)
json.body article.body.to_s
