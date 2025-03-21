#!/bin/bash

SCRIPT_DIR=$(dirname "$0")

set -o allexport
source $SCRIPT_DIR/mattermost.env
set +o allexport

CHANNEL=$1
TEMPLATE=$2

if [ -z "$CHANNEL" ]; then
	echo "Usage: ./send_reminder.sh CHANNEL MESSAGE_MARKDOWN_FILE"
	exit
fi

if [ ! -f "$TEMPLATE" ]; then
	echo "Usage: ./send_reminder.sh CHANNEL MESSAGE_MARKDOWN_FILE"
	exit
fi

if [ -z "$MATTERMOST_WEBHOOK_URL" ]; then
	echo "Must specify Mattermost webhook's URL in MATTERMOST_WEBHOOK_URL env variable"
	exit
fi

TODAY=${TODAY:-$(LC_ALL="en_US" date "+%B %d %Y")}

export TODAY

MESSAGE=$(cat $TEMPLATE | envsubst | jq -Rsa .)
CHANNEL=$(echo -n "$CHANNEL" | jq -Rsa .)

COMMAND="{\"channel\":${CHANNEL},\"text\":${MESSAGE}}"
echo -n $COMMAND | curl -X POST -H "Content-Type: application/json" -d @- $MATTERMOST_WEBHOOK_URL
