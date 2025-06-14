# たびくりっぷ
サービスURL：[たびくりっぷ](https://tabiclip.jp/)
![Image](https://github.com/user-attachments/assets/dff98fe3-58fb-4ff6-bf66-a80cb3bb4568)

## ■ サービス概要
「たびくりっぷ」は、web上で旅行のしおりを作成できるサービスです。
しおりを作成する際は公開or非公開の設定を選択できます。
作成したしおりは、公開して他のユーザーの旅行プランの参考にしたり、非公開にして自分だけの旅行記録として活用できます。
また、旅行メンバーをしおりに招待することで、しおりを共同編集することができます。
※現在国内のみ対応です

## ■ このサービスへの思い・作りたい理由
立ち寄りたいスポットの情報や距離感、宿泊施設や交通手段の手配、観光スポットや飲食店の検索・予約、予算や持ち物やお土産...などなど。
旅行計画を立てていると、調べることや用意するものが多く管理が大変だと感じています。
自身が旅行計画を立てる際にも、立ち寄りスポットの場所を調べるためにマップアプリを使用したり、調べたことをメモ帳アプリにまとめたり、
交通チケットや飲食店の予約受付前にリマインダーを設定したり、予算を計算したりと、多くのアプリやツールを駆使しています。
そんな旅行に関わる様々な情報を一元管理して楽にしたいという思いからこのサービスを開発に至りました。

## ■ ユーザー層について
- 詳細な旅行計画を立てたい方
	スケジュール表機能、持ち物やタスクのチェックリスト機能によって、旅行計画や準備のサポートをします。
- 旅行計画や準備を楽にしたい方
	旅行に関わる情報を一元管理できるため、たくさんのアプリやツールを行ったり来たりする必要がなくなります。
- 他の人の旅行計画を参考にしたい方
	公開設定されたしおりをエリアやカテゴリーごとに検索して参考にすることができます。
- 複数人での旅行を計画している方
	作成したしおり(スケジュールやチェックリスト)をシェアして旅行参加者全員で共通認識を持つことができます。
- 旅行の記録を残したい方
	マイページから作成したしおりを振り返ることができます。

## ■サービスの利用イメージ
- しおりの作成
公開/非公開を選択し、しおりを作成することができます。
しおりを作成すると、スケジュールやノート、リマインダー付きのチェックリストをしおりに紐づけて作成・管理することができます！
※公開にした場合、たびくりっぷユーザーが閲覧可能になり、非公開にした場合、しおりの作成者としおりに招待されたメンバーのみが閲覧可能です。

- しおりの検索
他のユーザーが公開設定で投稿したしおりとそのしおりに登録されたスケジュールを見ることができます。
しおりを見ることで旅行計画の参考していただくことを想定しています。

- しおりの共同編集
招待URLを送信することで、自分が参加しているしおりにメンバーを招待することができます。
しおりのメンバーになるとしおりの編集やしおりに紐づくノートやチェックリストを見ることができます。

## ■ ユーザーの獲得について
旅行者はSNSで情報収集する方が多いため、XやinstagramなどのSNSを活用して宣伝します。

## ■ サービスの差別化ポイント・推しポイント
### 比較サービス
- HareTabi - 旅行プラン作成ツール [リンク](https://www.haretabi.jp/)
- 共同編集できる旅行計画アプリ nicody（ニコディ）[リンク](https://nicody.jp/)
- おでかけ・旅行計画アプリ SASSY(サッシー)※モバイルアプリ[リンク](https://relyontrip.com/sassy/)
- 旅のしおり tabiori [リンク](https://tabiori.com/)

### 差別化ポイント
- しおりの公開/非公開設定：
	しおりを公開/非公開を切り替えることができます。
	※スケジュール以外(チェックリスト/アルバム/ノート)は非公開予定
- チェックリストのLINE通知機能：
	旅行前後にやるべきタスクなどのリマインダーとしてLINEのプッシュ通知を送ることでタスクの漏れを防ぎます。
	（活用例：飲食店の予約、旅行中の立替金精算など）
- 予算の自動計算機能：
	立ち寄りスポットごとに予算設定をすることができ、旅行中の予算を自動計算することができます。
	※tabioriには機能あり

## ■ 機能紹介
| 会員登録・ログイン | しおり一覧 |
|---|-----------------|
| <img src="https://i.gyazo.com/c4d45ced34b2ee35120cb634f1d003fb.png" alt="会員登録・ログイン"> | <img src="https://i.gyazo.com/4dc49f0ff3ac27b16aa12501001648bb.jpg" alt="しおり一覧"> |
| **devise**を用いて、標準的なメールアドレス/パスワード認証に加え、LINEログイン機能を実装しました。 | 公開設定で投稿されたしおりが一覧表示されます。**ransack**で検索機能を実装しており、エリア・旅行スタイルで絞って検索することができます。 |

| しおり作成 | メンバー招待 |
|---|-----------------|
| <img src="https://i.gyazo.com/97a1587287f2c980536ca1cd49a67fc8.png" alt="しおり作成" width="300"> | <img src="https://i.gyazo.com/cdfe56afc0f78cbb49c0071d043b246c.gif" alt="メンバー招待"> |
| 必須入力項目をタイトルのみにすることや、**stimulus**で開始日入力時に終了日に開始日をコピーするなどによりユーザーの入力負荷を軽減するための工夫をしました。 | しおりにメンバーをし招待することができます。招待URLを発行する方法か招待メールを送信する方法を選択できます。招待メールの送信は**devise_invitable**を用いて実装しました。 |

| スケジュール作成 | スケジュール一覧 |
|---|-----------------|
| <img src="https://i.gyazo.com/d0837763651d195be29eaed554701d53.gif" alt="スケジュール作成"> | <img src="https://i.gyazo.com/c1c60fbd7a66f158fb1d656f7b773098.gif" alt="スケジュール一覧"> |
| 必須入力をタイトルのみにすることや、**Places API**を用いて、場所名や住所のオートコンプリート機能を実装することでユーザーの入力負荷を軽減するための工夫をしました。 | **Maps JavaScript API**を用いて、スケジュール一覧の隣にマップを表示し(※768px以上の画面幅の場合)、日毎に登録された場所をマーカー表示しています。 |

| ノート | チェックリスト |
|---|-----------------|
| <img src="https://i.gyazo.com/297d504321fc44afb6e2ec83cff9396f.png" alt="ノート表示"> | <img src="https://i.gyazo.com/6c485f8a5981d38cf2ac2b625ad4e85c.png" alt="ノート表示"> |
| **redcarpet**を用いてマークダウン形式のテキストをHTMLに変換させることで、URLを含んだ文章を保存・表示できるようにしました。 | リマインダー機能をあわせ持つチェックリストを実装しました。任意の時間に**LINE**メッセージを送信します。 |

## 今後の開発について
### マップ機能の拡充
マップ上で場所の検索ができるようになれば、ユーザーの利便性向上につながると考えております。

### アルバム機能の追加
しおりに画像をアップロード・ダウンロードする機能を追加することで、ユーザーの利便性向上につながると考えております。

## 使用技術
| カテゴリ | 技術 |
| ---- | ---- |
| フロントエンド | Rails 7.2.1 / TailwindCSS / daisyUI / Hotwire |
| バックエンド | Rails 7.2.1 (Ruby 3.2.3) |
| データベース | PostgreSQL |
| 開発環境 | Docker |
| インフラ | Render / AmazonS3 |
| API | LINE Developers / Google Places API / Google Maps JavaScript API / Google Geocoding API |
| VCS | GitHub |
| CI/CD |  GitHub Actions |

## ■ 画面遷移図
https://www.figma.com/design/hFI7FPp7fZ95IcAQkhaPwx/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&t=G3nde0mVRNaHbNWf-1

## ■ ER図
https://drive.google.com/file/d/1dbgMbt2VltszC0EJGRvsLHx0v5A8Iyhb/view?usp=sharing

[![Image from Gyazo](https://i.gyazo.com/998168297275b3ab629c086029c8acda.png)](https://gyazo.com/998168297275b3ab629c086029c8acda)
