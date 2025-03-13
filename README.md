A very rudimentarycript automating sending recurring mattermost messages

Set up:
Create a file named `mattermost.env` configuring the Mattermost webhook to be used by defining `MATTERMOST_WEBHOOK_URL` variable. You can use `mattermost.env.template` provided in this repository.

Define your message in a markdown file. You can use a special variable `${TODAY}` in message text, which will be replaced with the current date while the message is sent.

Usage:
`./send_reminder.sh CHANNEL MESSAGE_MARKDOWN_FILE`
