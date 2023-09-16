class Category < ApplicationRecord
    # associaton many-to-many
    has_many :article_categories
    has_many :articles, through: :article_categories

    validates :name, presence: true#, uniqueness: { case_sensitive: false }
    validates_uniqueness_of :name
    validates :name, length: { minimum: 3, maximum: 25 }
end