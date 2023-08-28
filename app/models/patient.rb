class Patient < ApplicationRecord
  has_many :appointments
  has_many :dentists, through: :appointments

  validates :full_name, presence: true, format: { with: /\A[^0-9]+\z/, message: "não pode conter apenas números" }
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :cpf, :phone_number, presence: true, uniqueness: true, format: { with: /\A\d+\z/, message: "deve conter apenas dígitos numéricos" }
end
