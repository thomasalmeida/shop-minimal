class ProductsController < ApplicationController

  PRODUCTS_PER_PAGE = 5

  def index
    page = params.fetch(:page, 0).to_i
    name = params[:name] || ''

    @products = Product
      .where(status: true)
      .where("name LIKE ?", "%" + name + "%")
      .offset(page * PRODUCTS_PER_PAGE)
      .limit(PRODUCTS_PER_PAGE)
      .order('created_at')

    render json: @products
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private
    def product_params
      params.require(:product).permit(:name, :price, :photo_url)
    end
end

