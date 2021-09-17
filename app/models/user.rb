class User < ActiveRecord::Base
    has_secure_password
    has_many :subscriptions
    validates :email, uniqueness: true
end