# json.array! @homes, partial: 'homes/home', as: :home

if @post_new.present?
    json.id         @post_new.id
    json.message    @post_new.message
    json.date       @post_new.created_at.strftime("%Y-%m-%d")
end
