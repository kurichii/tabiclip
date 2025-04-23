require 'rails_helper'

RSpec.describe Note, type: :model do
  describe "バリデーションチェック" do
    it "タイトル、本文があれば有効であること" do
      note = build(:note)
      expect(note).to be_valid
      expect(note.errors).to be_empty
    end

    it "タイトル、本文は必須項目であること" do
      without_title = build(:note, title: nil, body: nil)
      expect(without_title).to be_invalid
      expect(without_title.errors[:title]).to include("を入力してください")
      expect(without_title.errors[:body]).to include("を入力してください")
    end

    it "タイトルが20文字以下であること" do
      too_long_title = build(:note, title: "a" * 21)
      expect(too_long_title).to be_invalid
      expect(too_long_title.errors[:title]).to include("は20文字以内で入力してください")
    end

    it "本文が65535文字以下であること" do
      too_long_body = build(:note, body: "a" * 65536)
      expect(too_long_body).to be_invalid
      expect(too_long_body.errors[:body]).to include("は65535文字以内で入力してください")
    end
  end
end
