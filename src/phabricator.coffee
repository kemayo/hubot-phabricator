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
#   HUBOT_PHABRICATOR_IGNORE=[T1000,D999,etc]
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
    # logger: console
  }
  conduit = createCanduit config,
    (error, conduit) ->

  ignore = (process.env.HUBOT_PHABRICATOR_IGNORE || '').replace(/\s+/g, '').split(',')

  # object (the TDPQFV bit is the things we recognize as prefixes)
  robot.hear /(?:^|[\[\s])([TDPQFV][0-9]+|r[A-Z]+[a-f0-9]+)(?:\s*(-v))?(?=\W|$)/g, (msg) ->
    names = (match.trim() for match in msg.match when match.trim() not in ignore)
    if names.length == 0
      return
    conduit.exec 'phid.lookup', {names: names}, (error, result) ->
      if error
        return
      hits = ("^ #{info.fullName} - #{info.uri}" for phid, info of result).join("\n")
      if hits
        msg.send hits
