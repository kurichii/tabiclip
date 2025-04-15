require 'rails_helper'

RSpec.describe TravelBook, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
    end
    it "titleがない場合にバリデーションが機能してinvalidになるか" do
    end
    it "titleが256文字以上の場合にバリデーションが機能してinvalidになるか" do
    end
    it "desctiptionが65536以上の場合にバリデーションが機能してinvalidになるか" do
    end
    it "end_dateがstart_dateより過去の場合にバリデーションが機能してinvalidになるか" do
    end
    it "titleが255文字以下の場合にバリデーションエラーが起きないか" do
    end
    it "descriptionが65535以下の場合にバリデーションエラーが起きないか" do
    end
    it "end_dateがstart_dateより未来の場合にバリデーションエラーが起きないか" do
    end
  end
end
