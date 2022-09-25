require 'rails_helper'

RSpec.describe "Categories", type: :system do
  describe "GET /show" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }

    before do
      binding.pry
      visit potepan_category_url(taxon.id)
    end

    it "タイトルが表示されること" do
      expect(page).to have_title "#{taxon.name} - BIGBAG Store"
    end

    it "カテゴリー名が表示されること" do
      expect(page).to have_content taxon.name
    end

    it "商品名が表示されること" do
      expect(page).to have_content product.name
    end
  end
end
