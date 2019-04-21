class Administrator < ApplicationRecord
  enum role: { normal: 0, admin: 1 }

  devise :database_authenticatable, :registerable, :recoverable, :validatable

  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 20 }

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end
