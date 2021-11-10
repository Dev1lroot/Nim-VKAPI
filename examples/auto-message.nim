import ../vkapi, os, md5, json, rdstdin, strutils

var peer = 0 #PEER ID
var resp: JsonNode
var last = 0
var send = 0
var uniq = 0
var frid = 0
var cmid = 0
var text = ""
var api = VKAPI(v: "5.131", t: "ACCESS TOKEN")

while true:
  resp = parseJson(api.getHistory(peer))
  send = 0
  uniq = 0
  frid = resp["response"]["items"][0]["from_id"].getInt()
  cmid = resp["response"]["items"][0]["conversation_message_id"].getInt()
  text = resp["response"]["items"][0]["text"].getStr()

  if last != cmid:
    last = cmid
    uniq = 1
    echo $frid & "> " & text

  if frid == peer:
    send = 1

  if send == 1 and uniq == 1:
    if text.contains("kekw"):
      send = 0
      discard api.sendMessage(peer,"1")
  if send == 1:
    discard api.sendMessage(peer,"Нихуя не понял, но очень интересно!")

  os.sleep(1000)
