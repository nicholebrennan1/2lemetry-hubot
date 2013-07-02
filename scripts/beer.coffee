# Description:
#   A way to interact with the Google Images API.
#
# Commands:
#   hubot suspenders - Pokes fun at Frank

module.exports = (robot) ->
  robot.respond /what's on tap\?/i, (msg) ->
    "<-- Ellie's Brown Ale ||| Mama's Little Yella Pils -->"
