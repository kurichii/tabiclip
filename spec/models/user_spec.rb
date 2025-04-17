require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    it "ユーザー名、メールアドレス、パスワードがあれば有効であること" do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it "アカウント名、メールアドレス、パスワードは必須項目であること" do
      user = build(:user, name: nil, email: nil, password: nil)
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("を入力してください")
      expect(user.errors[:email]).to include("を入力してください")
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "ユーザー名が30文字以下であること" do
      user = build(:user, name: "a" * 31)
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("は30文字以内で入力してください")
    end

    it "重複したメールアドレスの場合、無効であること" do
      user1 = create(:user)
      user2 = build(:user, email: user1.email)
      expect(user2).to be_invalid
      expect(user2.errors[:email]).to include("はすでに存在します")
    end
  end
end
