module ArticlesHelper
    search_preposition = {
        :city => "in",
        :rating => "for",
        :cuisine => "of"
    }
    
    def user_permissions_for_article(article)
        return nil unless signed_in?
        { edit: current_user.has_permission_to(:edit, article),
          delete: current_user.has_permission_to(:delete, article) }
    end

    def article_modify_links(article)
        { :'Edit Article' => edit_article_path(article),
          :'Delete Article' => {path: article_path(article), method: :delete, confirm: 'Are you sure you want to delete the article?'} }
    end

    def article_background_colour(article)
        return "style=\"background-color: #{article.primary_colour.present? ? article.primary_colour : @default_colours.first[1]}\"".html_safe
    end
end
