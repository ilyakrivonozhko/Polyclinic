# frozen_string_literal: true

class User < ApplicationRecord
  enum role: {basic: 0, medic: 1, receptionist: 2, admin: 3}, _suffix: :role
  # пациент / врач / регистратор / администратор
  
  attr_accessor :old_password, :remember_token, :admin_edit

  has_secure_password validations: false
  validates :password, confirmation: true, allow_blank: true, length: { minimum: 8, maximim: 70 }
  validate :password_complexity
  validate :correct_old_password, on: :update, if: -> { password.present? && !admin_edit }

  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
  validates :phone_number, presence: true, uniqueness: true
  validates :name, presence: true
  validates :surname, presence: true
  validates :patronymic, presence: true
  validates :role, presence: true
  validates :password_digest, presence: true

  def remember_me
    self.remember_token = SecureRandom.urlsafe_base64
    # rubocop:disable Rails/SkipsModelValidations
    update_column :remember_token_digest, digest(remember_token)
    # rubocop:enable Rails/SkipsModelValidations
  end

  def forget_me
    # rubocop:disable Rails/SkipsModelValidations
    update_column :remember_token_digest, nil
    # rubocop:enable Rails/SkipsModelValidations
    self.remember_token = nil
  end

  def guest?
    false
  end

  def remember_token_authenticated?(remember_token)
    return false if remember_token_digest.blank?

    BCrypt::Password.new(remember_token_digest).is_password?(remember_token)
  end

  private

  def digest(string)
    cost = if ActiveModel::SecurePassword
              .min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, 'is incorrect'
  end

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/

    errors.add :password,
               'complexity requirement not met. Length should be 8-70 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end
end
