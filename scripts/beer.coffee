# Description:
#   Tells us what's on tap in the office.
#
# Commands:
#   hubot beer menu - Tap info

module.exports = (robot) ->
  robot.respond /beer menu/i, (msg) ->
    msg.send """<-- Dry Dock Hefeweizen |||| Great Divide Colette -->"""
    #msg.send """We're fucking out."""
