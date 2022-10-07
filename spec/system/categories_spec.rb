require 'rails_helper'

RSpec.describe "Categories", type: :system do
  describe "GET /show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxonomy_taxon) { create(:taxon, taxonomy: taxonomy, parent_id: taxonomy.root) }
    let!(:taxon_product) { create(:product, taxons: [taxonomy_taxon]) }
    let!(:taxonomy_taxon1) { create(:taxon, name: "RUBY", taxonomy: taxonomy, parent: taxonomy.root) }
    let!(:taxon1_product) { create(:product, price: 23, taxons: [taxonomy_taxon1]) }
    let(:image) { create(:image) }

    before do
      taxon_product.images << image
      visit potepan_category_path(taxonomy_taxon.id)
      # 画像URL取得が上手くいかない問題への対応
      # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
      ActiveStorage::Current.host = page.current_host
    end

    describe "リンクテスト" do
      it "カテゴリー名をクリックで該当の商品一覧に遷移すること" do
        click_link taxonomy_taxon.name
        expect(current_path).to eq potepan_category_path(taxonomy_taxon.id)
      end

      it "一覧表示の商品をクリックで商品詳細ページへ遷移" do
        click_link taxon_product.name
        expect(current_path).to eq potepan_product_path(taxon_product.id)
      end
    end

    describe "表示テスト" do
      context "表示される場合のテスト" do
        it "タイトルが表示されること" do
          expect(page).to have_title "#{taxonomy_taxon.name} - BIGBAG Store"
        end

        it "カテゴリー名が表示されること" do
          within(".mainContent") do
            expect(page).to have_content taxonomy.name
            expect(page).to have_content taxonomy_taxon.name
            expect(page).to have_content taxonomy_taxon1.name
          end
        end

        it "カテゴリーに属する商品の数が表示されること" do
          expect(page).to have_content "#{taxonomy_taxon.name} (#{taxonomy_taxon.products.count})"
        end

        it "サイドバーに表示される商品数と一覧表示される商品の数が一致すること" do
          expect(page.all(".productCaption").count).to be page.all(".productBox").count
        end

        it "商品名が表示されること" do
          expect(page).to have_content taxon_product.name
        end

        it "商品価格が表示されること" do
          expect(page).to have_content taxon_product.display_price.to_s
        end
      end

      context "表示されない場合のテスト" do
        it "カテゴリー外の商品名が表示されないこと" do
          expect(page).not_to have_content taxon1_product.name
        end

        it "カテゴリー外の商品価格が表示されないこと" do
          expect(page).not_to have_content taxon1_product.display_price.to_s
        end
      end

      it "画像テスト" do
        taxon_product.reload.images.each do |image|
          expect(page).to have_selector "img[src$='#{image.attachment(:small)}']"
        end
      end
    end
  end
end
