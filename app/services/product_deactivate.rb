class ProductDeactivate
  attr_reader :product

  def initialize(product:)
    @product = product
  end

  def perform!
    product.update!(status: false)
  end
end
