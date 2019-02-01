class PlaylistCleaner < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  has_many :playlist_cleaner_users
  has_many :users, through: :playlist_cleaner_users

  validates :spotify_playlist_id, presence: true
end