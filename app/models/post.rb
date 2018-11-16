class Post < ApplicationRecord
  validates :message, presence: true, format: { with: /\A[\p{Hiragana}０-９0-9ー〜！？^\r\n\　]+\z/ }
end
