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
#
class User < ApplicationRecord

    validates :email, uniqueness: true, presence: true
    validates :password_digest, presence: true
    validates :password, length {minimum: 9}, allow_nil: true

    validate :session_token_validation


    private
    attr_reader :password
    def session_token_validation

    end

    def generate_unique_session_token
        SecureRandom::urlsafe_base64
    end
end
