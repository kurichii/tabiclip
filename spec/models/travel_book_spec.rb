require 'rails_helper'

RSpec.describe TravelBook, type: :model do
  describe "バリデーションチェック" do
    let(:today)     { Date.today }
    let(:yesterday) { Date.yesterday }
    let(:tomorrow)  { Date.tomorrow }

    it "設定したすべてのバリデーションが機能しているか" do
      travel_book = build(:travel_book)
      expect(travel_book).to be_valid
      expect(travel_book.errors).to be_empty
    end

    it "titleがない場合にバリデーションが機能してinvalidになるか" do
      without_title = build(:travel_book, title: "")
      expect(without_title).to be_invalid
      expect(without_title.errors[:title]).to include("を入力してください")
    end

    it "titleが256文字以上の場合にバリデーションが機能してinvalidになるか" do
      title = "a" * 256
      too_long_title = build(:travel_book, title: title)
      expect(too_long_title).to be_invalid
      expect(too_long_title.errors[:title]).to include("は255文字以内で入力してください")
    end

    it "desctiptionが65536以上の場合にバリデーションが機能してinvalidになるか" do
      description = "a" * 65536
      too_long_description = build(:travel_book, description: description)
      expect(too_long_description).to be_invalid
      expect(too_long_description.errors[:description]).to include("は65535文字以内で入力してください")
    end

    it "end_dateがstart_dateより過去の場合にバリデーションが機能してinvalidになるか" do
      end_date_before_start_date = build(:travel_book, start_date: today, end_date: yesterday)
      expect(end_date_before_start_date).to be_invalid
      expect(end_date_before_start_date.errors[:end_date]).to include("は開始日以降の日付を入力してください")
    end

    it "descriptionが65535以下の場合にバリデーションエラーが起きないか" do
      with_description = build(:travel_book, description: "description")
      expect(with_description).to be_valid
      expect(with_description.errors).to be_empty
    end

    it "end_dateがstart_dateより未来の場合にバリデーションエラーが起きないか" do
      end_date_after_start_date = build(:travel_book, start_date: today, end_date: tomorrow)
      expect(end_date_after_start_date).to be_valid
      expect(end_date_after_start_date.errors).to be_empty
    end
  end
end
