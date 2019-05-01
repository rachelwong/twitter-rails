class Tweet < ApplicationRecord
  resourcify 
  belongs_to :user

  # can edit if owner OR admin
  def can_edit?(user)
    return user == self.user || user.has_role?(:admin)
  end

  # can destroy if owner OR admin OR moderator
  def can_destroy?(user)
    return user == self.user || user.has_role?(:admin) || user.has_role?(:moderator)
  end
end