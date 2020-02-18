$(function(){

    function buildHTML(message){
      if ( message.image ) {
        var html =
          `<div class="message" data-message-id=${message.id}>
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
              </div>
              <img src=${message.image} >
          </div>`
        return html;
      } else {
        var html =
        `<div class="message" data-message-id=${message.id}>
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
            </div>
          </div>`
        return html;
      };
  }

    $('#new_message').on('submit', function(e){
      // console.log('OK');                            // イベントが発火したときにAjaxを使用して、messages#createが動く
      e.preventDefault();
      var formData = new FormData(this);            // イベントが発火したときに Ajaxを使用して、messagesコントローラのcreateアクションが動く
      var url = $(this).attr('action');             // onメソッドの内部では、$(this)と書くことでonメソッドを利用しているノードのオブジェクトが参照されます。つまり、今回の場合はform要素自体ということになります。
      $.ajax({                                      // attrメソッドによって、引数に指定した属性の値を取得することができます。今回は引数に'action'を指定しているので、form要素のaction属性の値が取得できます。検証で見ると"action="/groups/:id番号/messagesとなっており、必要なパスとなることがわかります。
        url: url,
        type: "POST",
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false
      })
      .done(function(data){
        // console.log(data)
        var html = buildHTML(data);
        $('.messages').append(html);                   // 受け取ったHTMLを、appendメソッドによって.messagesというクラスが適用されているdiv要素の子要素の一番最後に追加
        $('form')[0].reset();                          // フォームを空にする
        $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight}, 'fast');
      })
      .fail(function(){
        alert('メッセージの送信を失敗しました');
      })
      .always(function (data) {
        $('.form__submit').prop('disabled', false);
      })


    });
});
