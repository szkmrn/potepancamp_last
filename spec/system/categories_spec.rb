require 'rails_helper'

RSpec.describe "Categories", type: :system do
  describe "GET /show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
    let!(:product) { create(:product, taxons: [taxon]) }
    let!(:polo) { create(:product, name: "POLO", taxons: [taxon]) }
    let!(:taxon1) { create(:taxon, name: "RUBY", taxonomy: taxonomy, parent: taxonomy.root) }
    let!(:product1) { create(:product, price: 23, taxons: [taxon1]) }

    before do
      visit potepan_category_url(taxon.id)
    end

    describe "リンクテスト" do
      it "一覧表示の商品をクリックで商品詳細ページへ遷移" do
        click_link product.name
        expect(current_path).to eq potepan_product_path(product.id)
      end
    end

    describe "表示テスト" do
      context "表示される場合のテスト" do
        it "タイトルが表示されること" do
          expect(page).to have_title "#{taxon.name} - BIGBAG Store"
        end

        it "カテゴリー名(root)が表示されること" do
          expect(page).to have_content taxonomy.name
        end

        it "カテゴリー名が表示されること" do
          expect(page).to have_content taxon.name
          expect(page).to have_content taxon1.name
        end

        it "カテゴリーに属する商品の数が表示されること" do 
          expect(page).to have_content "#{taxon.name} (#{taxon.products.count})"
        end

        it "サイドバーに表示される商品数と一覧表示される商品の数が一致すること" do
          expect(page.all(".productCaption").count).to be taxon.products.count
        end

        it "商品名が表示されること" do
          expect(page).to have_content product.name
          expect(page).to have_content polo.name
        end

        it "商品価格が表示されること" do
          expect(page).to have_content product.display_price.to_s
          expect(page).to have_content polo.display_price.to_s
        end
      end

      context "表示されない場合のテスト" do
        it "カテゴリー外の商品名が表示されないこと" do
          expect(page).not_to have_content product1.name
        end

        it "カテゴリー外の商品価格が表示されないこと" do
          expect(page).not_to have_content product1.display_price.to_s
        end
      end
    end
  end
end
