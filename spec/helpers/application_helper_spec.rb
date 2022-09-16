require 'rails_helper'

RSpec.describe ApplicationHelper, typr: :helper do
  describe "#full_title" do
    it "引数が渡されている場合に動的な表示がなされること" do
      expect(full_title("sample")).to eq("sample | BIGBAG Store")
    end

    it "引数が空白の場合に動的な表示がされること" do
      expect(full_title("")).to eq("BIGBAG Store")
    end

    it "引数がnilの場合に動的な表示がされること" do
      expect(full_title(nil)).to eq("BIGBAG Store")
    end
  end
end
