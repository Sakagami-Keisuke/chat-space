$(function(){
  function buildHTML(message){
    image = ( message.image ) ? `<img class="lower-message__image" src=${message.image} >` : ""; 
    var html = ` <div class="message" data-message-id="${message.id}">
          <div class="upper-message">
            <div class="upper-message__user-name">
              ${message.user_name}
            </div>
            <div class="upper-message__date">
              ${message.created_at}
            </div>
          </div>
          <div class="lower-message">
            <p class="lower-message__content">
              ${message.content}
            </p>
            ${image}
          </div>
        </div>`
    return html; 
  }




    $('#new_message').on('submit', function(e){
      e.preventDefault();
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
        $('.messages').append(html);                 
        $('form')[0].reset();                         
        $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight}, 'fast');
      })
      .fail(function(){
        alert('メッセージの送信を失敗しました');
      })
      .always(function (data) {
        $('.form__submit').prop('disabled', false);
      })
    });



  let reloadMessages = function () {

    let last_message_id = $('.message:last').data("message-id");        
    if (window.location.href.match(/\/groups\/\d+\/messages/)){          
      
                                                                        
      $.ajax({                                                          
        url: "api/messages",                                             
        type: 'GET',                                                      
        dataType: 'json',                                             
        data: {last_id: last_message_id},                                 
        contentType: false
      }) 
      .done(function (messages) {                                 
        let insertHTML = '';                                          
        messages.forEach(function (message) {   
          if (message.id > last_message_id) {                      
            insertHTML = buildHTML(message);                           
            $('.messages').append(insertHTML);                                                      
            $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight}, 'fast');    
          }
        });
      })
      .fail(function(){
        alert('メッセージの送信を失敗しました');
      });
    } else {
      clearInterval(reloadMessages)
    }
  }
    setInterval(reloadMessages, 7000);

});
