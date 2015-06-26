# Hubot Phabricator

Auto-reply with descriptions and links to phabricator objects

## Installation

`npm install hubot-phabricator`

Then add `"hubot-phabricator"` to `external-scripts.json`

## Configuration

`HUBOT_PHABRICATOR_USER` - Required username for your phabricator instance, should match your certificate

`HUBOT_PHABRICATOR_CERT` - Required certificate for your phabricator instance (you can extract it from your `~/.arcrc`)

`HUBOT_PHABRICATOR_API` - Required URL for your API endpoint, e.g. `https://secure.phabricator.com/api/`

`HUBOT_PHABRICATOR_IGNORE` - Optional comma-separated list of phabricator objects that you want hubot to ignore.

## Commands

Hubot will listen for you mentioning something that sounds like a phabricator object, and will attempt to expand upon it.

Example:

    <danielle> Hey, I just submitted D1234, could everyone take a look?
    <hubot> ^ D1234: do awesome things that would be specified better in a real differential - https://secure.phabricator.com/D1234
    <danielle> It has to do with fixing up something from rAPPacd334 from last week.
    <hubot> ^ rAPPacd334: overly hasty commit to fix T4321 - https://secure.phabricator.com/rAPPacd334

