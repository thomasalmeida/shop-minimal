require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { described_class.new(name: 'Santa Claus', price: 13.12, photo_url: 'http://img.com') }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a name longer than 100 chars' do
    subject.name = 'p' * 101
    expect(subject).to_not be_valid
  end

  it 'is not valid without a price' do
    subject.price = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid when not number' do
    subject.price = 'xxx'
    expect(subject).to_not be_valid
  end

  it 'is not valid without a photo_url' do
    subject.photo_url = nil
    expect(subject).to_not be_valid
  end
end
