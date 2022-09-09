require 'rails_helper'

RSpec.describe "Products", type: :system do
  describe "GET /show" do
    let!(:product) { create(:spree_product, :skip_validate) }

    before do
      visit potepan_product_url(product.id)
    end

    it "HOMEリンクをクリックでトップページへの遷移" do
      click_link "home"
      expect(current_path).to eq potepan_path
    end

    it "商品名が取得されること" do
      expect(product.name).to eq("sweater")
    end
    it "商品価格が取得されること" do
      expect(product.price).to eq(23.45)
    end
    it "商品説明が取得されること" do
      expect(product.description).to eq("very hot!")
    end
  end
end
