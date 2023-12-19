class Food < ApplicationRecord
  belongs_to :consumer, class_name: 'User'
end
