require "rails_helper"

RSpec.describe "Users", type: :system do
  include LoginMacros
  # let!でテスト実行前に必ず実行
  let!(:user) { create(:user) }
  describe "ログイン前" do
    describe "ユーザー新規登録" do
      context "フォームの入力値が正常" do
        it "ユーザー作成が成功する" do
          visit "/users/sign_up"
          fill_in "ユーザー名", with: "たびくりっぷさん"
          fill_in "メールアドレス", with: "tabiclip@example.com"
          fill_in "パスワード", with: "password", match: :first
          fill_in "パスワード（確認用）", with: "password"
          click_button "アカウントを作成"
          expect(page).to have_content "アカウントを作成しました"
          expect(current_path).to eq public_travel_books_path
        end
      end

      context "メールアドレスが未入力" do
        it "ユーザー登録が失敗する" do
          visit "/users/sign_up"
          fill_in "ユーザー名", with: "たびくりっぷさん"
          fill_in "メールアドレス", with: ""
          fill_in "パスワード", with: "password", match: :first
          fill_in "パスワード（確認用）", with: "password"
          click_button "アカウントを作成"
          expect(page).to have_content "メールアドレスを入力してください"
          expect(current_path).to eq new_user_registration_path
        end
      end

      context "登録済みのメールアドレスを入力" do
        it "ユーザー登録が失敗する" do
          existed_user = create(:user)
          visit "/users/sign_up"
          fill_in "ユーザー名", with: "たびくりっぷさん"
          fill_in "メールアドレス", with: existed_user.email
          fill_in "パスワード", with: "password", match: :first
          fill_in "パスワード（確認用）", with: "password"
          click_button "アカウントを作成"
          expect(page).to have_content "メールアドレスはすでに存在します"
          expect(current_path).to eq new_user_registration_path
        end
      end
    end

    describe "マイページ" do
      context "ログインしていない状態" do
        it "マイページへのアクセスが失敗する" do
          visit "/profile"
          expect(page).to have_content "ログインが必要です"
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end

  describe "ログイン後" do
    before { login_as(user) }

    describe "ユーザー編集" do
      context "フォームの入力値が正常" do
        it "ユーザー編集が成功する" do
          visit "/users/edit"
          fill_in "ユーザー名", with: "たびくりっぷくん"
          fill_in "メールアドレス", with: "tabiclip@example.com"
          click_button "更新"
          expect(page).to have_content "アカウントを更新しました"
          expect(current_path).to eq profile_path
        end
      end

      context "メールアドレスが未入力" do
        it "ユーザー編集が失敗する" do
          visit "/users/edit"
          fill_in "ユーザー名", with: "たびくりっぷくん"
          fill_in "メールアドレス", with: ""
          click_button "更新"
          expect(page).to have_content "メールアドレスを入力してください"
          expect(current_path).to eq edit_user_registration_path
        end
      end

      context "登録済みのメールアドレスを入力" do
        it "ユーザー編集が失敗する" do
          existed_user = create(:user)
          visit "/users/edit"
          fill_in "ユーザー名", with: "たびくりっぷくん"
          fill_in "メールアドレス", with: existed_user.email
          click_button "更新"
          expect(page).to have_content "メールアドレスはすでに存在します"
          expect(current_path).to eq edit_user_registration_path
        end
      end
    end
  end
end
