class SchedulePolicy < ApplicationPolicy
  def index?
    # 非公開のしおりのスケジュールは所有者のみ閲覧可能
    record.is_public || record.owned_by_user?(user)
  end

  def new?
    # しおりの所有者のみ操作可能
    record.owned_by_user?(user)
  end

  def map?
    index?
  end
end
