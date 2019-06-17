$(function(){

  function buildHTML(message){
    var content = message.content ? `${message.content} ` : ''
    var image = message.image.url ? `<image src='${message.image.url}'> ` : ''

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
     
      $('.main-contents__body__list').append(html);
      $(".main-contents__body").animate({scrollTop:$('.main-contents__body__list')[0].scrollHeight});
      $("form")[0].reset();
    })
    .fail(function(){
      alert('error');
    })
  })
  var reloadMessages = function() {
    last_message_id = $('.main-contents__body__list__message').last().data('id');
    $.ajax({
      url: './api/messages',
      type: 'get',
      dataType: 'json',
      data: {id: last_message_id}
    })
    .done(function(messages) {
      var insertHTML = '';
      messages.forEach(function (data) {
          insertHTML = buildHTML(data); 
          $('.main-contents__body__list').append(insertHTML);
        })
        $('.main-contents__body').animate({scrollTop: $('.main-contents__body__list')[0].scrollHeight}, 'fast');
      })
      .fail(function () {
        alert('自動更新に失敗しました');
      });
    }
  
  setInterval(reloadMessages, 5000);
  });
