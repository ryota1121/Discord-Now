class Server < ApplicationRecord
  belongs_to :user
  
  validates :game_name, presence: true
  validates :game_name, length: { in: 2..20 }
  validates :title, presence: true
  validates :title, length: { in: 2..30 }
  validates :body, presence: true
  validates :body, length: { maximum: 200 }
  validates :tool, presence: true
  validates :tool, length: { in: 2..20 }

  
  validate :user_id_uniq_check
  
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
  
  def user_id_uniq_check
    if self.user.servers.any?
      errors.add(:base, "各ユーザーは一つの掲示板しか投稿できません")
    end
  end
end
