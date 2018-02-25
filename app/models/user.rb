class User < ApplicationRecord
    has_secure_password
    validates_uniqueness_of :email, :phone, :user_name
    before_create :generate_access_token
    mount_uploader :image, ImageUploader
    has_many :snaps
    has_many :follows
    has_many :followers
    has_many :feeds
    private
    def generate_access_token
        begin
            self.token = SecureRandom.hex
        end while self.class.exists?(token: token)
    end
end
