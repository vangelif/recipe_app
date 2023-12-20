require 'rails_helper'

RSpec.describe Food, type: :model do
    subject do
        Food.new(name: "chicken", measurement_unit: 'kg', price: '5.49', quantity: '1') 
    end
    before { subject.save }

    it "name must not be blank" do
        expect(subject).not_to be_valid
    end

    it "measurement unit must not be blank" do
        expect(subject).not_to be_valid
    end

    it "price must not be blank" do
        expect(subject).not_to be_valid
    end

    it "quantity must not be blank" do
        expect(subject).not_to be_valid
    end
end