class Article < ApplicationRecord
    # association one-to-many    
    belongs_to :user
    # association many-to-many through article_categories
    has_many :article_categories 
    has_many :categories, through: :article_categories
    
    validates :title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 400}
end
