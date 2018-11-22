# json.array! @homes, partial: 'homes/home', as: :home

if @unread.present?
    json.id         @unread.id
    json.message    @unread.message
    json.date       @unread.created_at.strftime("%Y-%m-%d")
    json.dst_id     @unread.dst_id
    json.src_id     @unread.src_id
end
if @reply.present?
    json.id         @reply.id
    json.message    @reply.message
    json.date       @reply.created_at.strftime("%Y-%m-%d")
    json.dst_id     @reply.dst_id
    json.src_id     @reply.src_id
end
json.user_id    @user
