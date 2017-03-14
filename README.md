# RMA
MACアドレスとSlackとGoogle SpreadSheetとGoogle Apps Scriptを利用した在室確認アプリです。  
活動場所に外部に出ているサーバーが無かったのでGoogleを利用していますが、本来はもっと楽に出来ると思います。
## 導入方法メモ
1. Google SpreadSheetを作成し、URLを控える。
1. GASでプロジェクトを[作成](https://www.google.com/script/start/)し、リポジトリにある`code.gs`をコピペ。 
1. プロジェクトにSlackを扱うためのライブラリを導入([Qiita紹介記事](http://qiita.com/soundTricker/items/43267609a870fc9c7453))。
1. 作成したプロジェクトにプログラム側からアクセスするための`config.json`を作成([参考](https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md))。  
1. SlackでOutgoingWebhooksトークンを作成。
1. GAS側にSlackのトークンとスプレッドシートのURLと、BOT用のユーザー名とアイコンを設定。
1. `.env`を作成し、`slack_hook`にはSlackのHookURLを、`spreadsheet_key`には作成したスプレッドシートの/d/と/edit/の間の部分を入れる。
1. ユーザー名とMACアドレスを組み合わせた`macs`テーブルを`room.db`で作成する。
```
CREATE TABLE macs(address varchar(32) not null,name varchar(32) not null);
```
## 利用方法
1. `network.rb`をcron使って5分間隔で動かす。
```
(5 * * * * bundle exec ruby network.rb)
```

参考
http://qiita.com/toC/items/1e13dada599614071f7c
