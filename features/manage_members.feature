#language: ja

フィーチャ: メンバー一覧を管理する
  minamirbist に参加しているメンバーを管理したい。
  各参加者は
  minamirbist に登録されているユーザ情報を登録したり変更したりしたい。

  シナリオ: 新規メンバーを登録する
    前提    "新規登録"ページを表示している
    もし    以下の項目を入力する:
            |名前          |小崎                  |
            |住所          |大阪某所              |
            |Eメール       |kozaki@gmail.com      |
            |ツイッターID  |koko_u                |
            |ブログURL     |http://www.kozaki.com/|
            |プロフィール  |もぞもぞしています    |
    かつ    "誕生日"の日付として"1973-12-30"を選択する
    かつ    "登録する"ボタンをクリックする
    ならば  以下のメンバーが表示される:
      |名前|住所    |Eメール         |ツイッターID|ブログURL             |誕生日    |プロフィール      |
      |小崎|大阪某所|kozaki@gmail.com|koko_u      |http://www.kozaki.com/|1973-12-30|もぞもぞしています|

  シナリオ: メンバーを削除する
    前提    "メンバー一覧"ページを表示している
    かつ    以下のメンバーが登録されている:
      |名前|住所  |Eメール       |ツイッターID|ブログURL        |誕生日    |プロフィール|
      |山田|その１|a1@gmail.com  |twit1       |http://blog1.com/|1999-01-01|風来坊      |
      |田中|その２|a2@gmail.com  |twit2       |http://blog2.com/|2000-02-02|イケメン    |
      |大谷|その３|a3@gmail.com  |twit3       |http://blog3.com/|2001-03-03|ばぶー      |
    もし    2番目のレコードを削除する
    ならば  以下のメンバーが表示される:
      |名前|住所  |Eメール       |ツイッターID|ブログURL        |誕生日    |プロフィール|
      |山田|その１|a1@gmail.com  |twit1       |http://blog1.com/|1999-01-01|風来坊      |
      |大谷|その３|a3@gmail.com  |twit3       |http://blog3.com/|2001-03-03|ばぶー      |

