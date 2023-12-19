class User < ApplicationRecord 
    has_many :recipes, foreign_key: :author_id
    has_many :foods, foreign_key: :consumer_id    
end