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
    # deviseのupdate処理を実行
    # これをしない場合、signinやバリデーションエラーが表示がデフォルトで行われなくなる
    super

    resource = self.resource

    if resource.errors.empty? && resource.invited_by_travel_book_id.present?
      # 中間テーブルに招待ユーザーと対象のしおりのidを保存
      user_travel_book = UserTravelBook.new(
        user_id: resource.id,
        travel_book_uuid: resource.invited_by_travel_book_id
      )
      if user_travel_book.save
        flash[:notice] = "しおりのメンバーに追加されました"
      else
        flash[:alert] = "しおりのメンバーに追加できませんでした"
      end
    end
  end

  def destroy
    super
  end

  protected

  # ユーザーが招待を承認したあとに招待されたしおりの詳細ページにリダイレクト
  def after_accept_path_for(resource)
    travel_book_id = resource.invited_by_travel_book_id
    if travel_book_id.present?
      travel_book_path(travel_book_id)
    else
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [ :name ])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [ :name ])
  end
end
