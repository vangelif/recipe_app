require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'jeremy') }
  before { subject.save }

  it 'name must not be blank' do
    expect(subject).not_to be_valid
  end
end
# end
# end
