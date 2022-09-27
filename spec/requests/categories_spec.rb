require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /show" do
    let(:taxon) { create(:taxon) }
    let!(:product) { create(:product, taxons: [taxon]) }

    before do
      get potepan_category_url(taxon.id)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "商品名が表示されること" do
      expect(response.body).to include product.name
    end

    it "商品価格が表示されること" do
      expect(response.body).to include product.display_price.to_s
    end
  end
end
