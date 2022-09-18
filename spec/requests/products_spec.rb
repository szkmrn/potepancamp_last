require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /show" do
    let(:product) { create(:product) }

    before do
      get potepan_product_url(product.id)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "商品名が表示されていること" do
      expect(response.body).to include product.name
    end

    it "商品価格が表示されていること" do
      expect(response.body).to include product.display_price.to_s
    end

    it "商品詳細が表示されていること" do
      expect(response.body).to include product.description
    end
  end
end
