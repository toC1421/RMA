function doPost(e) {
  var slackApp = SlackApp.create("Slackで取得したトークン");
  var data = gss();
  var name = "現在活動場所に居るメンバー\n";
  data.some(function(val,index,ar){
    if (val == "") {
      name +="\n";
      return true;
    }
    name += val+"\n";
  });
  if(name.length <= 15){
    name = "活動場所には誰も居ません";
  }
  slackApp.chatPostMessage("送信するチャンネル",name, {
    username : "Slackに送信するユーザー名",
    icon_emoji : "ユーザーのアイコン例(:house:)"
  });
}　
function gss(){
  var url = "作成したスプレッドシートのURL";
　var spreadsheet = SpreadsheetApp.openByUrl(url);
  var sheets = spreadsheet.getSheets();
  var sheet = sheets[0];
  var startrow = 1;
  var startcol = 1;
  var lastrow = sheet.getLastRow();
  var lastcol = sheet.getLastColumn();
  var sheetdata = sheet.getSheetValues(startrow, startcol, lastrow, lastcol);
  return sheetdata;
}
