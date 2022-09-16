class AddPrimaryColourToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :primary_colour, :string
  end
end
