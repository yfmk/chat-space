json.content  @message.content
json.image  @message.image
json.user_name  @message.user.name
json.is_content_present  @message.content.present?
json.is_image_present  @message.image.present?
json.id  @message.id
json.date @message.created_at.strftime("%Y/%m/%d %H:%M")
