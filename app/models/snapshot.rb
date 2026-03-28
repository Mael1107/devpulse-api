class Snapshot < ApplicationRecord
  belongs_to :user
  validates :date, :commits_count, presence: true
end
