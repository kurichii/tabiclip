class TravelBookOwnerPolicy < ApplicationPolicy
  def show?
    # 所有者のみ閲覧可能
    record.owned_by_user?(user)
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end
