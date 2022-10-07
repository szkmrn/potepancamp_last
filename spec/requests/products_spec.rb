require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /show" do
    let(:product) { create(:product) }
    let!(:taxon) { create(:taxon, products: [product]) }
    let(:image) { create(:image)}

    before do
      product.images << image
      get potepan_product_path(product.id)
      # 画像URL取得が上手くいかない問題への対応
      # https://mng-camp.potepan.com/curriculums/document-for-final-task-2#notes-of-image-test
      ActiveStorage::Current.host = request.base_url
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "商品名が表示されていること" do
      expect(response.body).to include product.name
    end

    it "商品価格が表示されていること" do
      expect(response.body).to include product.display_price.to_s
    end

    it "商品詳細が表示されていること" do
      expect(response.body).to include product.description
    end

    it "商品画像が表示されていること" do
      product.images.reload.each do |image|
        expect(response.body).to include image.attachment(:large)
        expect(response.body).to include image.attachment(:small)
      end    
    end
  end
end
