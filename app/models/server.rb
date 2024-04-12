class Server < ApplicationRecord
  belongs_to :user
  belongs_to :server
  
  validates :game_name, presence: true
  validates :game_name, length: { in: 1..20 }
  validates :title, presence: true
  validates :title, length: { in: 1..30 }
  validates :body, presence: true
  validates :tool, presence: true
  validates :tool, length: { in: 1..20 }
  validates :link, presence: true
  
  has_one_attached :icon
  has_many :server_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def get_icon(width, height)
    unless icon.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      icon.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    icon.variant(resize_to_limit: [width, height]).processed
  end
  
  def self.keyword_search(keyword)
    where("game_name like ?", "%#{keyword}%")
    .or(where("tool like ?", "%#{keyword}%"))
    .or(where("title like ?", "%#{keyword}%"))
    .or(where("body like ?", "%#{keyword}%"))
  end
  
end
