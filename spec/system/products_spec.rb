require 'rails_helper'

RSpec.describe "Products", type: :system do
  describe "GET /show" do
    let(:product) { create(:product, name: "T-shirts", taxons: [taxon]) }
    let!(:taxon) { create(:taxon) }
    let(:image) { create(:image) }

    before do
      product.images << image
      visit potepan_product_path(product.id)
      # 画像URL取得が上手くいかない問題への対応
      # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
      ActiveStorage::Current.host = page.current_host
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

    it "商品画像が表示されること" do
      product.images.reload.each do |image|
        expect(page).to have_selector "img[src='#{image.attachment(:large)}']"
        expect(page).to have_selector "img[src='#{image.attachment(:small)}']"
      end
    end
  end
end
