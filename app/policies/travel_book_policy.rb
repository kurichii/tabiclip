class TravelBookPolicy < ApplicationPolicy
  def show?
    # 非公開のしおりは所有者のみ閲覧可能
    record.is_public or record.owned_by_user?(user)
  end

  def edit?
    record.owned_by_user?(user)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def delete_image?
    edit?
  end

  def share?
    edit?
  end

  def delete_owner?
    edit?
  end

  def invitation?
    edit?
  end
end
