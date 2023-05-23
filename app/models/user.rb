class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true
    validates :phone_number, presence: true, uniqueness: true
    validates :name, presence: true
    validates :surname, presence: true
    validates :patronymic, presence: true
    #validates :role, presence: true
    validates :password_digest, presence: true

end
