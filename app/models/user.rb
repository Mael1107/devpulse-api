class User < ApplicationRecord
  validates :github_uid, :username, presence: true
end
