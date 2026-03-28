class User < ApplicationRecord
  has_many :snapshots
  
  validates :github_uid, :username, presence: true
end
