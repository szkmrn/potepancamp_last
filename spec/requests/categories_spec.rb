require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /show" do
    let!(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let!(:product) { create(:product, taxons: [taxon]) }
    let!(:polo) { create(:product, name: "POLO", taxons: [taxon]) }
    let!(:taxon1) { create(:taxon, name: "RUBY", taxonomy: taxonomy, parent: taxonomy.root) }
    let!(:product1) { create(:product, price: 23, taxons: [taxon1]) }

    before do
      get potepan_category_url(taxon.id)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    describe "表示テスト" do
      context "表示される場合のテスト" do
        it "カテゴリー名(root)が表示されること" do
          expect(response.body).to include taxonomy.name
        end

        it "カテゴリー名が表示されること" do
          expect(response.body).to include taxon.name
          expect(response.body).to include taxon1.name
        end

        it "商品名が表示されること" do
          expect(response.body).to include product.name
          expect(response.body).to include polo.name
        end

        it "商品価格が表示されること" do
          expect(response.body).to include product.display_price.to_s
          expect(response.body).to include polo.display_price.to_s
        end
      end

      context "表示されない場合のテスト" do
        it "カテゴリー外の商品名が表示されないこと" do
          expect(response.body).not_to include product1.name
        end

        it "カテゴリー外の商品価格が表示されないこと" do
          expect(response.body).not_to include product1.display_price.to_s
        end
      end
    end
  end
end
