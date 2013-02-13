# Description:
#   Hubot Time Utils
#
# Commands:
#   hubot epoch to date <sec/ms/us> - Convert epoch time to MST

module.exports = (robot) ->
  robot.respond /epoch to date (.*)/i, (msg) ->
    mydate = new Date()
    
    #msg.send msg.match[1].length
    
    if msg.match[1].length == 16
       mydate.setTime(msg.match[1]/1000)
       msg.send mydate
    else if msg.match[1].length == 13
       mydate.setTime(msg.match[1])
       msg.send mydate
    else if msg.match[1].length == 10
       mydate.setTime(msg.match[1]*1000)
       msg.send mydate
    else
       msg.send "I'm not sure.  Was that number seconds, milliseconds or microseconds?"
