class InviteCode < ActiveRecord::Base
  validates :code, :uniqueness => true
end
