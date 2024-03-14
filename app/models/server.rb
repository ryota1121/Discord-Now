class Server < ApplicationRecord
  belongs_to :user
  validates :game_name, presence: true
  validates :server_name, presence: true
  validates :title, presence: true
  validates :body, presence: true
  
  has_one_attached :icon
  
  def get_icon(width, height)
    unless icon.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      icon.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    icon.variant(resize_to_limit: [width, height]).processed
  end
  
  def self.keyword_search(keyword)
    where("game_name like ?", "%#{keyword}%")
    .or(where("server_name like ?", "%#{keyword}%"))
    .or(where("title like ?", "%#{keyword}%"))
    .or(where("body like ?", "%#{keyword}%"))
  end
end
