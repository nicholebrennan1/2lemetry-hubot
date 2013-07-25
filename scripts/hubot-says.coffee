# Description:
#
# Commands:
#   hubot says - Hubot Speaks

mqtt = require('mqtt')
crypto = require('crypto')


sayings = [
  "I hear that!",
  "That's what your mom said.",
  "I know.  But don't tell Jason.",
  "Un hunh.  Yep.  Wait, what?",
  "What you talkin 'bout Hubot?",
  "If I had a dollar for all the times I've heard that.",
  "Oh, puuuulleeease.",
  "Amen, brother!",
  "Can I get a, \"Hell yeah?!\"",
  "Exception!  Just kidding....that's a robot joke.",
  "I just heard a bum on the 16th Street Mall yell the same thing.",
    "Please refrain from making derogatory comments about my mother.",
+  "What do you know about flow swagger you sad little man?",
+  "Put on some pants and find your dignity immediately.",
+  "Hey now. Let's not get too sassy people.",
+  "I find such language offensive.",
+  "Your mother is a cougar. A mediocre looking one at that."
]


module.exports = (robot) ->
  robot.respond /say (.*)/i, (msg) ->

    user = process.env.M2MIO_USER
    pass = process.env.M2MIO_PASS
    
    client = mqtt.createClient 1883, 'q.m2m.io',
      keepalive: 10
      clientId: 'hubot'
      username: user
      password: crypto.createHash('md5').update(pass).digest('hex')

    client.on 'connect', () ->
      client.publish """io.m2m/officeautomation/hubot""", "{\"command\":\"say\", \"phrase\":\"" + msg.match[1] + "\"}"

      client.end

      msg.send msg.random sayings
