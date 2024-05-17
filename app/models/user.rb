class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :servers, dependent: :destroy
  has_many :server_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_servers, through: :favorites, source: :server

  has_one_attached :profile_image

  validates :name, presence: true
  validates :name, length: { in: 1..10 }
  validates :name, uniqueness: true, on: :create

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def find_or_create_from_auth_hash(auth_hash)
    user_params = user_params_from_auth_hash(auth_hash)
    find_or_create_by(uid: user_params[:uid]) do |user|
      user.update(user_params)
    end
  end

  def favorite(server)
    favorites.find_or_create_by(server_id: server.id)
  end

  def unfavorite(server)
    favorites.find_by(server_id: server.id)&.destroy
  end

  def favorite?(server)
    favorite_servers.include?(server)
  end

private

  def user_params_from_auth_hash(auth_hash)
    {
      name: auth_hash.info.name,
      email: auth_hash.info.email,
      image: auth_hash.info.image,
      uid: auth_hash.uid,
    }
  end
end
