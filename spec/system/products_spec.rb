require 'rails_helper'

RSpec.describe "Products", type: :system do
  describe "GET /show" do
    let(:product) { create(:product, name: "T-shirts") }
    let!(:taxon) { create(:taxon, products: [product]) }

    before do
      visit potepan_product_path(product.id)
    end

    it "タイトルが表示されること" do
      expect(page).to have_title "#{product.name} - BIGBAG Store"
    end

    it "HOMEリンクをクリックでトップページへの遷移" do
      click_link "home"
      expect(current_path).to eq potepan_path
    end

    it "一覧ページへ戻るをクリックでトップページへの遷移" do
      click_link "一覧ページへ戻る"
      expect(current_path).to eq potepan_category_path(taxon.id)
    end

    it "商品名が表示されること" do
      expect(page).to have_content "T-shirts"
    end

    it "商品価格が表示されること" do
      expect(page).to have_content "$19.99"
    end

    it "商品説明が表示されること" do
      expect(page).to have_content "As seen on TV!"
    end
  end
end
