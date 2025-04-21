require 'rails_helper'

RSpec.describe "TravelBooks", type: :system do
  include LoginMacros
  let!(:user) { create(:user) }
  let!(:travel_book) { create(:travel_book, creator: user) }
  let!(:user_travel_book) { create(:user_travel_book, user: user, travel_book: travel_book) }

  describe "ログイン前" do
    describe "ページ遷移確認" do
      context "しおりの新規作成ページにアクセス" do
        it "新規登録ページへのアクセスが失敗する" do
          visit new_travel_book_path
          expect(page).to have_content("ログインが必要です")
          expect(current_path).to eq new_user_session_path
        end
      end

      context "しおりの編集ページにアクセス" do
        it "編集ページへのアクセスが失敗する" do
          visit edit_travel_book_path(travel_book)
          expect(page).to have_content("ログインが必要です")
          expect(current_path).to eq new_user_session_path
        end
      end

      context "しおりの詳細ページにアクセス" do
        it "詳細ページへのアクセスが成功する" do
          visit edit_travel_book_path(travel_book)
          expect(page).to have_content("ログインが必要です")
          expect(current_path).to eq new_user_session_path
        end
      end

      context "しおりの一覧ページにアクセス" do
        it "一覧ページへのアクセスが成功する" do
          # しおりを3つ作成
          public_travel_book_list = create_list(:travel_book, 3, is_public: true)
          # 各しおりに中間テーブルに紐づけ
          public_travel_book_list.each do |public_travel_book|
            create(:user_travel_book, user: user, travel_book: public_travel_book)
          end
          visit public_travel_books_path
          expect(page).to have_content public_travel_book_list[0].title
          expect(page).to have_content public_travel_book_list[1].title
          expect(page).to have_content public_travel_book_list[2].title
          expect(current_path).to eq public_travel_books_path
        end
      end

      context "マイしおりの一覧ページにアクセス" do
        it "マイしおり一覧ページへのアクセスが失敗する" do
          visit travel_books_path
          expect(page).to have_content("ログインが必要です")
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end

  describe "ログイン後" do
    before { login_as(user) }

    describe "しおりの新規登録" do
      context "フォームの入力値が正常" do
        it "しおりの新規作成に成功する" do
          expect(page).to have_content("しおり作成")
          visit new_travel_book_path
          expect(page).to have_content("タイトル")
          fill_in "タイトル", with: "タイトル"
          click_button "登録"
          # expect(page).to have_content("しおりを作成しました")
          # expect(current_path).to eq travel_books_path
          expect(page).to have_content "しおりを作成しました"
          expect(current_path).to eq "/travel_books"
        end
      end

      context "タイトルが未入力" do
        it "しおりの新規登録に失敗する" do
          expect(page).to have_content("しおり作成")
          visit new_travel_book_path
          expect(page).to have_content("タイトル")
          fill_in "タイトル", with: ""
          click_button "登録"
          expect(page).to have_content("しおりを作成できませんでした")
          expect(current_path).to eq new_travel_book_path
        end
      end
    end

    describe "しおりの編集" do
      context "フォームの入力値が正常" do
        it "しおりの編集に成功する" do
          visit edit_travel_book_path(travel_book.uuid)
          expect(page).to have_content("しおり編集")
          fill_in "タイトル", with: "新しいタイトル"
          click_button "更新"
          expect(page).to have_content("しおりを更新しました")
          expect(travel_book.reload.title).to eq("新しいタイトル")
        end
      end

      context "タイトルが未入力" do
        it "しおりの編集に失敗する" do
          visit edit_travel_book_path(travel_book.uuid)
          expect(page).to have_content("しおり編集")
          fill_in "タイトル", with: ""
          click_button "更新"
          expect(page).to have_content("しおりを更新できませんでした")
          expect(current_path).to eq edit_travel_book_path(travel_book.uuid)
        end
      end
    end

    describe "しおりの削除" do
      it "しおりの削除が成功する" do
        visit travel_book_path(travel_book.uuid)
        expect(page).to have_content(travel_book.title)
        # confirmダイアログでOKを選択する
        accept_confirm do
          find('.fa-trash').click
        end
        expect(page).to have_content("しおりを削除しました")
        expect(current_path).to eq travel_books_path
      end
    end
  end
end
