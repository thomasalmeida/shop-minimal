require 'rails_helper'

RSpec.describe "Products", type: :request do
  before do
    9.times { |n| FactoryBot.create(:product, name: "Product##{n}") }
    FactoryBot.create(:product, name: 'SuperProduct')
  end

  describe 'GET /products' do
    context 'without params' do
      before { get '/products' }

      it 'returns products' do
        expect(response.body).not_to be_empty
        expect(JSON.parse(response.body).size).to eq(5)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'given valid page param' do
      before { get '/products?page=1'}

      it 'returns all products in that page' do
        product_ids = JSON.parse(response.body).map{|p| p['id']}
        expect(product_ids).not_to include(Product.first.id)
        expect(product_ids).to include(Product.last.id)
      end
    end

    context 'given valid name param' do
      let!(:product) { Product.where(name: 'SuperProduct').first }

      before { get "/products?name=#{product.name[2..8]}" }

      it 'returns all products that matches with name param' do
        body = JSON.parse(response.body)
        expect(body.size).to eq(1)
        expect(Product.find(product.id)).to have_attributes(
          name: body.first['name'],
          price: body.first['price'].to_f,
          photo_url: body.first['photo_url'],
          status: body.first['status'],
        )
      end
    end
  end

  describe 'POST /products' do
    let(:valid_attributes) {{ product: { name: 'Santa Claus', price: 13.12, photo_url: 'http://img.com' }}}

    context 'when the request is valid' do
      before { post '/products', params: valid_attributes }

      it 'creates a product' do
        expect(JSON.parse(response.body)['name']).to eq(valid_attributes[:product][:name])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/products', params: { product: {name: '' }}}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/can't be blank/)
      end

      context 'when the product name is duplicate' do
        params = { product: { name: 'Rudolph', price: 13.12, photo_url: 'http://img.com' }}
        before do
          post '/products', params: params
          post '/products', params: params
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message' do
          expect(response.body).to match(/has already been taken/)
        end
      end
    end

  end

  describe 'PATCH /products/:id/deactivate' do
    context 'when the record exists' do
      let!(:product) { Product.where(status: true).first }

      before { patch "/products/#{product.id}/deactivate" }

      it 'deactivates the record' do
        expect(response.body).to match(/inactivated/)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      context 'when the record was inactived' do
        before { patch "/products/#{product.id}/deactivate" }

        it 'returns error message' do
          expect(response.body).to match(/already deactivated/)
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end




