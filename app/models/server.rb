class Server < ApplicationRecord
  belongs_to :user
  validates :game_name, presence: true
  validates :server_name, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
