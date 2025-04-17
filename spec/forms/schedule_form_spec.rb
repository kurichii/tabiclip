require 'rails_helper'

RSpec.describe ScheduleForm, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
    end

    it "titleがない場合にバリデーションが機能してinvalidになるか" do
    end

    it "titleが256文字以上の場合にバリデーションが機能してinvalidになるか" do
    end

    it "end_dateがstart_dateより過去の場合にバリデーションが機能してinvalidになるか" do
    end

    it "budgedが0未満の場合にバリデーションが機能してinvalidになるか" do
    end

    it "memoが65536文字以上の場合にバリデーションが機能してinvalidになるか" do
    end

    it "schedule_icon_idがScheduleIconのidの範囲意外の場合にバリデーションが機能してinvalidになるか" do
    end

    it "end_dateがstart_dateより未来の場合にバリデーションエラーが起きないか" do
    end

    it "memoが65535以内の場合にバリデーションエラーが起きないか" do
    end
  end
end
