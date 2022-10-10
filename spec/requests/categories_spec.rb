require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let(:taxon_product) { create(:product, taxons: [taxon]) }
    let(:taxon1) { create(:taxon, name: "RUBY", taxonomy: taxonomy, parent: taxonomy.root) }
    let(:taxon1_product) { create(:product, price: 23, taxons: [taxon1]) }
    let(:image) { create(:image) }

    before do
      taxon_product.images << image
      get potepan_category_path(taxon.id)
      # 画像URL取得が上手くいかない問題への対応
      # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
      ActiveStorage::Current.host = request.base_url
    end

    it "httpリクエストが成功すること" do
      expect(response).to have_http_status(:success)
    end

    describe "表示テスト" do
      context "表示される場合のテスト" do
        it "カテゴリー名が表示されること" do
          within(".mainContent") do
            expect(response.body).to include taxonomy.name
            expect(response.body).to include taxon.name
            expect(response.body).to include taxon1.name
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

      it "画像テスト" do
        taxon_product.reload.images.all? do |image|
          expect(response.body).to include image.attachment(:small)
        end
      end
    end
  end
end
