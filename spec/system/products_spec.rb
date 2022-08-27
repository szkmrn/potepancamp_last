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
  end
end
