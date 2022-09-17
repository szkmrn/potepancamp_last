require 'rails_helper'

RSpec.describe "Products", type: :system do
  describe "GET /show" do
    let(:product) { create(:spree_product, :skip_validate) }

    before do
      visit potepan_product_url(product.id)
    end

    it "HOMEリンクをクリックでトップページへの遷移" do
      click_link "home"
      expect(current_path).to eq potepan_path
    end

    it "商品名が表示されること" do
      expect(page).to have_content "sweater"
    end

    it "商品価格が表示されること" do
      expect(page).to have_content "23.45"
    end

    it "商品説明が表示されること" do
      expect(page).to have_content "very hot!"
    end
  end
end
