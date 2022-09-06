require 'rails_helper'

RSpec.describe "Potepan:s", type: :request do
  # describe "GET /potepan:s" do
  #   it "works! (now write some real specs)" do
  #     get potepan:s_path
  #     expect(response).to have_http_status(200)
  #   end
  # end

  describe "GET /potepan/index" do
    it "正常にレスポンスを返すこと" do
      get "/potepan/index"
      expect(response).to have_http_status(200)
    end
  end
end
