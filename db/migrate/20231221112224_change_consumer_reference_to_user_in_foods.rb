class ChangeConsumerReferenceToUserInFoods < ActiveRecord::Migration[7.1]
  def change
    remove_reference :foods, :consumer, index: true
    add_reference :foods, :user, null: false, foreign_key: true
  end
end
