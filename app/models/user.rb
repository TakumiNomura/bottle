class User < ApplicationRecord
  has_many :receives
  has_many :posts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :rememberable, :omniauthable, :registerable
  # :database_authenticatable,:recoverable,:validatable, :registerable :trackable,
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    # email = auth["email"].nil? ? auth["provider"] + auth["uid"] + "@login.function" : auth["email"]

    unless user
      user = User.create(
          uid:      auth.uid,
          provider: auth.provider,
          # email:    User.dummy_unique_email(auth),
          # email:    email,
          # password: Devise.friendly_token[0, 20],
          image_url: auth.info.image,
          name: auth.info.name,
          nickname: auth.info.nickname
          )
    end

    return user
  end

#   def remember_me
#     true
#   end
  # def forget
  #   update_attribute(:remember_digest, nil)
  # end
  # private

  # def self.dummy_unique_email(auth)
  #   "#{auth.uid}-#{auth.provider}@example.com"
  # end
end
