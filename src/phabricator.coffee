# Description
#   Auto-reply with descriptions and links to phabricator objects
#
# Dependencies:
#   "canduit": "!1.0.0"
#
# Configuration:
#   HUBOT_PHABRICATOR_USER=username
#   HUBOT_PHABRICATOR_API=api-uri
#   HUBOT_PHABRICATOR_CERT=certificate
#
# Commands:
#   [TDPQFV]12345 - respond with a description of the phabricator object referenced
#
# Author:
#   kemayo

createCanduit = require('canduit')

module.exports = (robot) ->
  config = {
    user: process.env.HUBOT_PHABRICATOR_USER
    api: process.env.HUBOT_PHABRICATOR_API
    cert: process.env.HUBOT_PHABRICATOR_CERT
  }
  conduit = createCanduit config,
    (error, conduit) ->

  # object (the TDPQFV bit is the things we recognize as prefixes)
  robot.hear /(?:^|[\[\s])([TDPQFV][0-9]+|r[A-Z]+[a-f0-9]+)(?:\s*(-v))?(?=\W|$)/, (msg) ->
    conduit.exec 'phid.lookup', {names: [msg.match[1]]}, (error, result) ->
      if error
        return
      for phid, info of result
        msg.send '^ ' + info.fullName + ' - ' + info.uri
        # switch info.type
          # could do this... lot of extra work just for the username of the person it's assigned to
          # when 'TASK'
          #   conduit.exec 'maniphest.info', {task_id: info.name.slice(1)}, (error, result) ->
          #     owner = result.ownerPHID
          #     # fetch owner via phid.info...

          #     msg = "^ " + info.name + " - " + result.title + ". Assigned to " + owner['fullName'] + ". " + result.uri
