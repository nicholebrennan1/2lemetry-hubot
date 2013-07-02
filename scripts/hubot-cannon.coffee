# Description:
#
# Commands:
#   hubot fire! - Hubot Fires the Marshmallow Cannon

mqtt = require('mqtt')
crypto = require('crypto')


sayings = [
  "Fire in the hole!",
  "Booo-hoooom!",
  "Aye-aye, sir.",
  "Robot down.  Robot down."
]


module.exports = (robot) ->
  robot.respond /fire!/i, (msg) ->

    user = process.env.M2MIO_USER
    pass = process.env.M2MIO_PASS

    client = mqtt.createClient 1883, 'q.m2m.io',
      keepalive: 10
      clientId: 'hubot'
      username: user
      password: crypto.createHash('md5').update(pass).digest('hex')

    client.on 'connect', () ->
      client.publish """io.m2m/officeautomation/cannon""", "{\"command\":\"FIRE\"}"

      client.end

      msg.send msg.random sayings