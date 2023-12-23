require 'rails_helper'

RSpec.describe Recipe, type: :model do
  @author = User.new(name: 'jeremy')
  subject do
    Recipe.new(author: @author, name: 'Chicken Tika Masala', description: '', preparation_time: 30,
               cooking_time: 90)
  end
  before { subject.save }

  it 'author must not be blank' do
    subject.author = nil
    expect(subject).not_to be_valid
  end

  it 'recipe must not be blank' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'preparation time must not be blank' do
    subject.preparation_time = nil
    expect(subject).not_to be_valid
  end

  it 'cooking time must not be blank' do
    subject.cooking_time = nil
    expect(subject).not_to be_valid
  end
end
