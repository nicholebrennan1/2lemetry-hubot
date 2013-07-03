# Description:
#   Tells us what's on tap in the office.
#
# Commands:
#   hubot beer menu - Tap info

module.exports = (robot) ->
  robot.respond /beer menu/i, (msg) ->
    msg.send """<-- Ellie's Brown Ale |||| Mama's Little Yella Pils -->"""
