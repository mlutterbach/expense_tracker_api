class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :password_digest, type: String

  has_many :expenses, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_secure_password
end
