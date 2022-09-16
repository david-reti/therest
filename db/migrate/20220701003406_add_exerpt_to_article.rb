class AddExerptToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :exerpt, :string
  end
end
