$(function(){

  function buildHTML(message){
    var content = message.is_content_present ? `${message.content} ` : ''
    var image = message.is_image_present ? `<img src='${message.image.url}'> ` : ''

    var html = `<div class = "main-contents__body__list__message" data-id=${message.id}>
                  <div class = "main-contents__body__list__message__name">
                    ${message.user_name}
                  </div>
                  <div class = "main-contents__body__list__message__data">
                    ${message.date}
                  </div>
                  <div class = "main-contents__body__list__message__body">
                    ${content}
                    ${image}
                  </div>
                </div>`
    return html;
  }

  $('#new_message').on('submit', function(e){
    e.preventDefault();
    e.stopPropagation();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $("form")[0].reset();
    })
    .fail(function(){
      alert('error');
    })
  })
}); 