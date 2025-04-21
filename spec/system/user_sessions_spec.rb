require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }

  describe "ログイン前" do
    context "フォームの入力値が正常" do
      it "ログイン処理が成功する" do
        visit "/users/sign_in"
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "password"
        click_button "ログイン"
        expect(page).to have_content "ログインしました"
        expect(current_path).to eq public_travel_books_path
      end
    end

    context "フォームが未入力" do
      it "ログイン処理が失敗する" do
        visit "/users/sign_in"
        fill_in "メールアドレス", with: ""
        fill_in "パスワード", with: "password"
        click_button "ログイン"
        expect(page).to have_content "メールアドレス またはパスワードが無効です"
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe "ログイン後" do
    context "ログアウトボタンをクリックする" do
      it "ログアウト処理が成功する" do
        login_as(user)
        find("label.drawer-button").click
        expect(page).to have_content "ログアウト"
        click_on "ログアウト"
        expect(page).to have_content "ログアウトしました"
        expect(current_path).to eq root_path
      end
    end
  end
end
