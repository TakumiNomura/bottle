class Post < ApplicationRecord
  validates :message, presence: true, format: { with: /\A[\p{Hiragana}]+\z/ }
end
