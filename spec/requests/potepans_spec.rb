require 'rails_helper'

RSpec.describe "Potepan:s", type: :request do
  describe "GET potepan_path" do
    it "正常にレスポンスを返すこと" do
      get potepan_url
      expect(response).to have_http_status(200)
    end
  end
end
