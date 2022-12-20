# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  username        :string           not null
#
class User < ApplicationRecord

    validates :username, uniqueness: true, presence: true
    validates :email, uniqueness: true, presence: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 5}, allow_nil: true
    before_validation :ensure_session_token

    def self.find_by_creds(email, password)
        user = self.find_by(email: params[:email])

        if user && user.is_password?(password)
            user
        else
            nil 
        end
    end

    def reset_session_token!
        self.session_token = generate_unique_session_token
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        password_obj = BCrypt::Password.new(self.password_digest)
        password_obj.is_password?(password)
    end

    private
    attr_reader :password

    def generate_unique_session_token
        SecureRandom::urlsafe_base64
    end
end
