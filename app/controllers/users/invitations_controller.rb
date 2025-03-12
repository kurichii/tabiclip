class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters

  def new
    super
  end

  def create
    user_email = params[:user][:email]
    travel_book_uuid = params[:user][:travel_book_uuid]
    travel_book = TravelBook.find_by(uuid: travel_book_uuid)
    user = User.find_by(email: user_email)

    if user.present?
      user.invite!(current_user)
      user.update(invited_by_travel_book_id: travel_book_uuid)
      redirect_to travel_book_path(travel_book), notice: "招待メールが #{user_email} に送信されました"
    else
      user = User.invite!({ email: user_email }, current_user)
      user.update(invited_by_travel_book_id: travel_book_uuid)
      if user.valid?
        redirect_to travel_book_path(travel_book), notice: "招待メールが #{user_email} に送信されました"
      else
        flash[:alert] = "メールアドレスを正しく入力してください"
        render "new", locals: { invited_by_travel_book_id: travel_book_uuid, resource: User.new, resource_name: :user }
      end
    end
  end

  def edit
    super
  end

  def update
    # リダイレクト先を招待されたしおりのビューにリダイレクトさせるために、元々の承認後の動作をオーバーライド
    self.resource = accept_resource

    # オーバーライドする場合、自分でサインインしないといけないみたい(オーバーライドする際は自動ログイン)
    sign_in(resource_name, resource)

    # createアクションでuserに保存しておいたしおりのidを取得
    travel_book_uuid = resource.invited_by_travel_book_id

    if travel_book_uuid.present?
      # 中間テーブルに招待ユーザーと対象のしおりのidを保存
      user_travel_book = UserTravelBook.new
      user_travel_book.user_id = resource.id
      user_travel_book.travel_book_uuid = travel_book_uuid
      user_travel_book.save

      travel_book = TravelBook.find_by(uuid: travel_book_uuid)
      # 招待されたしおりにリダイレクト
      redirect_to travel_book_path(travel_book), notice: "#{travel_book.title} に参加しました"
    else
      redirect_to root_path, notice: "しおりに参加できませんでした"
    end
  end

  def destroy
    super
  end

  private

  # 招待を受け入れる処理をオーバーライド
  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
    resource
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [ :name ])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [ :name ])
  end
end
