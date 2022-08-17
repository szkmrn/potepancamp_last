require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /show" do
    let(:product) { FactoryBot.create(:spree_product, :skip_validate) }

    before do
      get potepan_product_url(product.id)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
