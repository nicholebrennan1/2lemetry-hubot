# Description:
#
# Commands:
#   hubot fire! - Hubot Fires the Marshmallow Cannon

mqtt = require('mqttjs/lib/mqtt')
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
    
    mqtt.createClient 1883, 'q.m2m.io', (error, client) ->
      client.connect
        versionNum: 3.1
        keepalive: 3000
        client: 'hubot'
        username: user
        password: crypto.createHash('md5').update(pass).digest('hex')

      #client.publish {topic: 'public/john/test', payload: msg}
      #client.publish { topic: "public/john/test", payload: msg, "qos": 0, "retain": false }
      #console.log msg.match[1]
      #client.close

      client.on 'connack', (packet) ->
        if packet.returnCode is 0
          client.publish
            topic: """io.m2m/officeautomation/cannon"""
            payload: "{\"command\":\"FIRE\"}"
            qos: 0
            retain: false
          #console.log 'connack'
          client.disconnect
          client.close
          msg.send msg.random sayings
        else
          console.log 'connack error ' + packet.returnCode
          console.log JSON.stringify(packet)
          process.exit -1

      client.on 'publish', (packet) ->
        console.log 'Someone said ' + packet.payload + ' on ' + packet.topic

      client.on 'close', ->
        #console.log 'close'
        #process.exit 0

      client.on 'puback', (packet) ->
        console.log '     [MQTT-COMMS] ' + client_id + ' puback received.'

      client.on 'pubrec', (packet) ->
        console.log '\t [MQTT-COMMS] ' + client_id + ' pubrec received, replying with pubcomp.'
        client.pubcomp messageId: packet.messageId

      client.on 'suback', (packet) ->

      client.on 'error', (e) ->
        console.log e
        #process.exit -1
