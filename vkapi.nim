import httpclient, json, times, strutils

type
  VKAPI* = ref object of RootObj
    v*: string
    t*: string

proc getMethod*(api: VKAPI, m: string): string =
  return "https://api.vk.com/method/" & m & "?access_token=" & api.t & "&v=" & api.v

proc getRequest*(api: VKAPI, m: string, args: string): string =
  var i = api.getMethod(m) & args
  echo i
  var o = newHttpClient().getContent(i)
  #echo o
  return o

proc getHistory*(api: VKAPI, userid: int): string =
  return api.getRequest("messages.getHistory", "&count=1&filters=8&user_id=" & $userid & "&offset=0")

proc sendMessage*(api: VKAPI, userid: int, message: string): string =
  var m = message.replace(" ","+")
  return api.getRequest("messages.send", "&peer_id=" & $userid & "&random_id=" & $toUnix(getTime()) & "&message=" & m )

proc getWall*(api: VKAPI, userid: int, count: int): string =
  return api.getRequest("wall.get", "&owner_id=" & $userid & "&filter=owner&count=" & $count )
