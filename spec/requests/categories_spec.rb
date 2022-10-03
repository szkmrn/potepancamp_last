require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxonomy_taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let!(:taxon_product) { create(:product, taxons: [taxonomy_taxon]) }
    let!(:taxonomy_taxon1) { create(:taxon, name: "RUBY", taxonomy: taxonomy, parent: taxonomy.root) }
    let!(:taxon1_product) { create(:product, price: 23, taxons: [taxonomy_taxon1]) }

    before do
      get potepan_category_path(taxonomy_taxon.id)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    describe "表示テスト" do
      context "表示される場合のテスト" do
        it "カテゴリー名が表示されること" do
          within(".mainContent") do
            expect(response.body).to include taxonomy.name
            expect(response.body).to include taxonomy_taxon.name
            expect(response.body).to include taxonomy_taxon1.name
          end
        end

        it "商品名が表示されること" do
          expect(response.body).to include taxon_product.name
        end

        it "商品価格が表示されること" do
          expect(response.body).to include taxon_product.display_price.to_s
        end
      end

      context "表示されない場合のテスト" do
        it "カテゴリー外の商品名が表示されないこと" do
          expect(response.body).not_to include taxon1_product.name
        end

        it "カテゴリー外の商品価格が表示されないこと" do
          expect(response.body).not_to include taxon1_product.display_price.to_s
        end
      end
    end
  end
end
