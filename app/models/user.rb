# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  validates :slack_id, presence: true, uniqueness: true
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@nimblehq\.co\z/,
                              message: 'must be a nimble account' }
end
