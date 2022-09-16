class Permission < ApplicationRecord
    include Immutable
    has_and_belongs_to_many :roles
    enum permission_type:  [ :create_article, :edit_own_article, :edit_all_articles, :delete_own_article, :delete_all_articles,
                             :create_comment, :edit_own_comment, :delete_own_comment, :delete_all_comments   ]
end
