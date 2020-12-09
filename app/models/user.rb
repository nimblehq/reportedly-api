class User < ApplicationRecord
  has_many :reports, dependent: :destroy
  has_one :subscription, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  validates :slack_id, presence: true, uniqueness: true
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@nimblehq\.co\z/,
                              message: 'must be a nimble account' }
end
