class AddTimestampsToArticles < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, "created_at"
    remove_column :articles, "updates_at"
  end
end
