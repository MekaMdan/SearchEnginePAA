class Word < ApplicationRecord
  has_many :pages
  validates :word, uniqueness: true
end
