$(function() {
  function addUser(user) {                       //引数に値が入っていた場合とそうじゃない場合のhtmlを生成し、それらをぶち込む//一致するユーザーがいた場合の処理
    let html = `                  
      <div class="chat-group-user clearfix">
        <p class="chat-group-user__name">${user.name}</p>
        <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
      </div>
    `;
    $("#user-search-result").append(html);       //作ったhtmlをぶち込む
  }

  function addNoUser() {                         //一致するユーザーがいなかった場合の処理
    let html = `
      <div class="chat-group-user clearfix">
        <p class="chat-group-user__name">ユーザーが見つかりません</p>
      </div>
    `;
    $("#user-search-result").append(html);       //作ったhtmlをぶち込む
  }
  function addDeleteUser(name, id) {              //削除ボタンが押された時の処理
    let html = `
    <div class="chat-group-user clearfix" id="${id}">
      <p class="chat-group-user__name">${name}</p>
      <div class="user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn" data-user-id="${id}" data-user-name="${name}">削除</div>
    </div>`;
    $(".js-add-user").append(html);             //作ったhtmlをぶち込む
  }
  function addMember(userId) {                   //ユーザーをグループに登録するための処理//userのidをinputタグの初期値としそれをnameを使ってgroupsコントローラ内のparamsで受け取る準備
    let html = `<input value="${userId}" name="group[user_ids][]" type="hidden" id="group_user_ids_${userId}" />`;
    $(`#${userId}`).append(html);                 //作ったinputタグをaddDeleteUser内で作ったhtml内にぶち込む
  }
  $("#user-search-field").on("keyup", function() {   // ⑶テキストフィールドに入力されるたびにイベントが発火するようにする//検索欄に文字入力されるたびに処理を行う
    let input = $("#user-search-field").val();        //検索欄に入力された文字をvalで取得し変数inputに代入
    $.ajax({                                        // ⑷イベント時に非同期通信できるようにする
      type    :  "GET",                             // users GET  メソッド指定
      url     :  "/users",                           // /users(.:format)  url指定
      data    : { keyword: input },                   //コントローラーに渡すデータ keyを自分で決め(今回は"keyword"と定義)valueには先ほど検索欄から取得し代入したinputの値を使う
      dataType: "json",                            //データ形式を指定
    })
      .done(function(users) {                   //⑸&⑹非同期通信の結果を得て、HTMLを作成しビュー上に追加する //jbuilderファイルで作った配列を引数にしdone関数を起動 //ちゃんと動いているかを確認するために一時的にconsole.log
        $("#user-search-result").empty();        //if,else if,elseどの場合においても、処理後は、すでに検索欄に出力されている情報を削除する。

        if (users.length !== 0) {               //検索に一致するユーザーが０じゃない場合(いる場合)
          users.forEach(function(user) {         //usersという配列をforEachで分解し、ユーザーごとにaddUser関数に飛ばす(処理は後ほど)
            addUser(user);
          });
        } else if (input.length == 0) {          //入力欄に文字が入力されてない場合処理を終了
          return false;
        } else {                                 //検索に一致するユーザーがいない場合はaddNoUserに飛ばす
          addNoUser();
        }
      })
      .fail(function() {                        //⑺エラー時の処理を行う  //ちゃんと動いているかを確認するために一時的にconsole.log
        alert("通信エラーです。ユーザーが表示できません。");
      });
  });        //↓⑻、⑼追加ボタンが押された時にクリックされたユーザーの名前を、チャットメンバーの部分に追加し、検索結果からは消す
  $(document).on("click", ".chat-group-user__btn--add", function() {    
    ////追加ボタンがクリックされた時の処理を記述する
    const userName = $(this).attr("data-user-name");  //クリックされたところのデータを取得し各変数に代入
    const userId = $(this).attr("data-user-id");
    $(this)   //クリックされたところのhtmlを親要素をごと消す（検索結果から消す）
      .parent()
      .remove();
    addDeleteUser(userName, userId);             //削除ボタンの書いてあるhtmlを呼び出す処理に飛ばす
    addMember(userId);                            //ユーザーをグループに登録するための処理
  });
  $(document).on("click", ".chat-group-user__btn--remove", function() {     //⑽削除を押すと、チャットメンバーから削除される
    $(this)       //削除を押すと、チャットメンバーから削除される//クリックされたところのhtmlを親要素をごと消す（検索結果から消す）
      .parent()
      .remove();
  });
});



// 検索入力のタグである #user-search-field を指定しjQueryオブジェクトを取得します。「テキストフィールドに文字が入力されるたびにイベントを発火させるメソッド」はkeyupとし、入力するためにキーが押された後、上がるタイミングで処理が実行されるようにします。
// 処理には「フォームの値を取得する時に使用するメソッド」である valメソッド を使用して値を取得し、コンソールに表示されるようなものにします。

// rails routes
// Prefix Verb   URI Pattern       Controller#Action
// users GET    /users(.:format)    users#index

// 検索結果に応じて、検索結果が該当する場合と、しない場合で条件分岐をします。
// 検索結果は配列に格納されるので、lengthメソッドを使用して条件分岐が可能です。
// 返り値がない場合はreturn falseと記述し、返り値がない事を伝えることで可読性が向上することが期待できます。
// 検索結果が該当ありの場合は、forEach文を使用しユーザーごとHTMLを描画していきます。
// addUserという関数を定義し、HTMLを用意します。${} を使用する事でテンプレートリテラル内で式展開が可能です。これを使用してユーザーの名前などを表示できるよう実装していきます。
// appendメソッド を使用してHTMLを描画するように記述します。

// 追加ボタンが押された際に処理が実行
// $(document).onすることで常に最新のHTMLの情報を取得
// $(document).onを用いることで、Ajax通信で作成されたHTMLの情報を取得
// 今回だとappendさせて作成したHTMLから情報を取得する際、documentを用いることで値の取得を可能

// 追加ボタンの対象であるユーザー情報を変数へ代入し、HTMLを描画
// その際、検索結果欄からメンバー欄へ移動するように見せるために検索結果欄からremoveメソッドを使用してHTMLは削除

// ユーザーの追加や削除の情報は addMember というメソッドを作成してコントロール
// ここではメンバーを追加する際に情報を user_idsへ追加できるような仕組みを作り、削除ボタンを押すと同時にその情報も削除されるように実装



// 実装内容について

// -Controllerからhtmlをレスポンスとするコードを削除しても問題なく動作するか（非同期通信がそもそも出来ているのか）
// -適切にインクリメンタルサーチできるか
// -自分が検索結果に表示されないようになっているか
// -自分がデフォルトでチャットメンバーに追加されるようになっているか
// -追加ボタンを押したらチャットメンバーに追加されるか
// -削除ボタンを押したらチャットメンバーから削除されるか
// -関数名は処理の内容を過不足なく表現できるような名前になっているか
// -変数名はデータの内容を過不足なく表現できるような名前になっているか
// -グループ新規作成が正常に行われるか（追加したユーザー全員がグループのメンバーとなるか）
// -グループの編集が行えるか（編集画面移行時に、既存ユーザーが削除されないか）
// -binding.pryやconsole.logなどのデバッグ用の記載は消去してあるか
// -コードのインデントは適切に取ってあるか（全角スペースはNGです）