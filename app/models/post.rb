class Post < ApplicationRecord
  validates :message, presence: true, format: { with: /\A[\p{Hiragana}０-９ー〜！？^\r\n\　]+\z/ }
end
