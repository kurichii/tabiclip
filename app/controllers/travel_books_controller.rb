class TravelBooksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ show public_travel_books accept ]
  before_action :set_travel_book, only: %i[ edit update destroy delete_image share delete_owner invitation ]
  # 設定したprepare_meta_tagsをprivateにあってもpostコントローラー以外にも使えるようにする
  helper_method :prepare_meta_tags

  def index
    @travel_books = current_user.travel_books.order(created_at: :desc).page(params[:page])
  end

  def new
    @travel_book = TravelBook.new
  end

  def create
    @travel_book = current_user.travel_books.build(travel_book_param)
    @travel_book.creator_id = current_user.id

    if @travel_book.save
      # 中間テーブルに関連付けを追加
      current_user.user_travel_books.create(travel_book: @travel_book)
      redirect_to travel_books_path, notice: t("defaults.flash_message.created", item: TravelBook.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: TravelBook.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @travel_book = TravelBook.find_by(uuid: params[:uuid])
    # メタタグを設定
    prepare_meta_tags(@travel_book)
  end

  def edit; end

  def update
    if @travel_book.update(travel_book_param)
      redirect_to travel_books_path(@travel_book), notice: t("defaults.flash_message.updated", item: TravelBook.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: TravelBook.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @travel_book.destroy!
    redirect_to travel_books_path, notice: t("defaults.flash_message.deleted", item: TravelBook.model_name.human)
  end

  def delete_image
    @travel_book.remove_travel_book_image! # CarrierWaveのメソッドを使って画像を削除
    @travel_book.save
    redirect_to edit_travel_book_path(@travel_book), notice: "しおりの画像を削除しました"
  end

  def public_travel_books
    @q = TravelBook.ransack(params[:q])
    @travel_books = @q.result.where(is_public: true).includes(:users).order(created_at: :desc).page(params[:page])
  end

  def share
    @users = @travel_book.users
    @user = User.new
    @resource_name = @user.class.name.underscore
    @invite_link = accept_travel_book_url(invitation_token: @travel_book.invitation_token) if @travel_book.invitation_token.present?
  end

  def delete_owner
    user = User.find(params[:user_id])
    # しおりの作成者でない場合のみ削除
    return redirect_to share_travel_book_path(@travel_book.uuid), alert: "しおりの作成者は削除できません" if user == @travel_book.creator

    @travel_book.users.destroy(user)
    if user == current_user
      redirect_to public_travel_books_path, notice: "しおりのメンバーから削除しました"
    else
      redirect_to share_travel_book_path(@travel_book.uuid), notice: "しおりのメンバーから削除しました"
    end
  end

  def search
    @q = TravelBook.ransack(params[:q])
    @results = @q.result
  end

  def bookmarks
    @bookmark_travel_books = current_user.bookmark_travel_books.order(created_at: :desc)
  end

  def invitation
    if @travel_book.generate_token
      @invite_link = accept_travel_book_url(invitation_token: @travel_book.invitation_token)
    else
      redirect_to share_travel_book_path(@travel_book.uuid), alert: "招待リンクが作成できませんでした"
    end
  end

  def accept
    @travel_book = TravelBook.find_by(invitation_token: params[:invitation_token])
    # しおりがない場合、公開しおり一覧にリダイレクト
    return redirect_to public_travel_books_path, alert: "招待URLが無効です" unless @travel_book
    # ログインしていない場合に招待されたしおりを特定するためにセッションにしおりのuuidを保存
    session[:travel_book_uuid] = @travel_book.uuid

    if user_signed_in?
      # ログインしている場合
      # すでにしおりのメンバーに参加している場合
      if @travel_book.owned_by_user?(current_user)
        redirect_to travel_book_path(@travel_book.uuid), notice: "すでにしおりに参加しています"
      else
        # しおりのメンバーに参加していない場合
        # 中間テーブルに招待ユーザーと対象のしおりのidを保存
        user_travel_book = UserTravelBook.new(user_id: current_user.id, travel_book_id: @travel_book.id)
        if user_travel_book.save
          redirect_to travel_book_path(@travel_book.uuid), notice: "しおりのメンバーに追加されました"
        else
          redirect_to public_travel_books_path, alert: "しおりのメンバーに追加できませんでした"
        end
      end
      # セッションを無効にする
      session[:travel_book_uuid] = nil
    else
      # ログインしていない場合
      session[:after_sign_in_path] = accept_travel_book_url(invitation_token: params[:invitation_token])
      redirect_to new_user_session_path, alert: "ログインしてください"
    end
  end

  private

  def prepare_meta_tags(travel_book)
    # image_url
    image_url = "#{request.base_url}/images/ogp.png?title=#{CGI.escape(travel_book.title)}&creator=#{CGI.escape(travel_book.creator.name)}"

    set_meta_tags og: {
      site_name: "たびくりっぷ",
      title: "#{travel_book.title} | たびくりっぷ",
      description: "旅行のしおりの投稿です",
      type: "website",
      url: request.original_url,
      image: image_url,
      local: "ja-JP"
    },
    twitter: {
      card: "summary_large_image",
      site: "@https://x.com/kuripiyoco",
      image: image_url
    }
  end

  def set_travel_book
    @travel_book = current_user.travel_books.find_by(uuid: params[:uuid])
  end

  def travel_book_param
    params.require(:travel_book).permit(:title, :description, :is_public, :area_id, :traveler_type_id, :start_date, :end_date, :travel_book_image, :travel_book_image_cache)
  end
end
