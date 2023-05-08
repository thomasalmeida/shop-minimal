require 'rails_helper'

describe ProductDeactivate do
  let!(:product) { FactoryBot.create(:product) }

  describe '.perform!' do
    subject { described_class.new(product: product).perform! }

    it 'Set status to inactive' do
      is_expected.to eq(true)
      expect(product.status).to be false
    end
  end
end
