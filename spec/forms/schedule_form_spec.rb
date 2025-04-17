require 'rails_helper'

RSpec.describe ScheduleForm, type: :model do
  let(:schedule_icon) { ScheduleIcon.find(1) }
  let(:travel_book) { create(:travel_book) }
  let(:attributes) do
    {
      title: "title",
      budged: 0,
      travel_book_id: travel_book.id,
      schedule_icon_id: schedule_icon.id,
      start_date: nil,
      end_date: nil,
      memo: nil,
      schedule_image: nil,
      name: nil,
      telephone: nil,
      post_code: nil,
      address: nil
    }
  end

  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      schedule_form = ScheduleForm.new(attributes)
      expect(schedule_form).to be_valid
      expect(schedule_form.errors).to be_empty
    end

    it "titleがない場合にバリデーションが機能してinvalidになるか" do
      without_title = attributes.merge(title: nil)
      schedule_form = ScheduleForm.new(without_title)
      expect(schedule_form).to be_invalid
      expect(schedule_form.errors[:title]).to include("を入力してください")
    end

    it "titleが256文字以上の場合にバリデーションが機能してinvalidになるか" do
      too_long_title = attributes.merge(title: "a" * 256)
      schedule_form = ScheduleForm.new(too_long_title)
      expect(schedule_form).to be_invalid
      expect(schedule_form.errors[:title]).to include("は255文字以内で入力してください")
    end

    it "end_dateがstart_dateより過去の場合にバリデーションが機能してinvalidになるか" do
      end_date_before_start_date = attributes.merge(start_date: Date.today, end_date: Date.yesterday)
      schedule_form = ScheduleForm.new(end_date_before_start_date)
      expect(schedule_form).to be_invalid
      expect(schedule_form.errors[:end_date]).to include("は開始時刻より後の時刻を入力してください")
    end

    it "budgedが0未満の場合にバリデーションが機能してinvalidになるか" do
      negative_budged = attributes.merge(budged: -1)
      schedule_form = ScheduleForm.new(negative_budged)
      expect(schedule_form).to be_invalid
      expect(schedule_form.errors[:budged]).to include("は0以上の値にしてください")
    end

    it "memoが65536文字以上の場合にバリデーションが機能してinvalidになるか" do
      too_long_memo = attributes.merge(memo: "a" * 65536)
      schedule_form = ScheduleForm.new(too_long_memo)
      expect(schedule_form).to be_invalid
      expect(schedule_form.errors[:memo]).to include("は65535文字以内で入力してください")
    end

    it "schedule_icon_idがScheduleIconのidの範囲意外の場合にバリデーションが機能してinvalidになるか" do
      out_of_schedule_icon_id = attributes.merge(schedule_icon_id: 100)
      schedule_form = ScheduleForm.new(out_of_schedule_icon_id)
      expect(schedule_form).to be_invalid
      expect(schedule_form.errors[:schedule_icon_id]).to include("は一覧にありません")
    end

    it "end_dateがstart_dateより未来の場合にバリデーションエラーが起きないか" do
      end_date_after_start_date = attributes.merge(start_date: Date.today, end_date: Date.tomorrow)
      schedule_form = ScheduleForm.new(end_date_after_start_date)
      expect(schedule_form).to be_valid
      expect(schedule_form.errors).to be_empty
    end

    it "memoが65535以内の場合にバリデーションエラーが起きないか" do
      with_memo = attributes.merge(memo: "memo")
      schedule_form = ScheduleForm.new(with_memo)
      expect(schedule_form).to be_valid
      expect(schedule_form.errors).to be_empty
    end
  end
end
