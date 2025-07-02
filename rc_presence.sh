#!/bin/bash

# Generate a token at Account -> Personal Access Token
RC_TOKEN="TOKEN_HERE"
RC_USER="USER_ID_HERE"

RC_URL="https://vshn.chat"
RC_ROOM="Po6ekjaAHNYMs6rAQ" # ID of virtual-presence channel


# Customize your messages to your liking. The script picks from the appropriate list at random.
GREETINGS=("Hello :wave:" "Good day" ":wave:" "Halli hallo")
GOODBYES=("Off for the day, see you!" "Goodbye :wave:" "Done for the day :wave:")
BREAK=("Off for a break :tea:" "AFK for a bit" "Taking a break :negroni:" )
RETURN=("I'm back." "re" ":back:")



HEADERS=(-H "X-User-Id: $RC_USER" -H "X-Auth-Token: $RC_TOKEN" -H "Accept: application/json" -H "Content-Type: application/json")

case $1 in
    goodbye)
        GREETING_TODAY=${GOODBYES[ $RANDOM % ${#GOODBYES[@]} ]}
        ;;
    break)
        GREETING_TODAY=${BREAK[ $RANDOM % ${#BREAK[@]} ]}
        ;;
    return)
	sleep 5 # Wait for network services to be available again
        GREETING_TODAY=${RETURN[ $RANDOM % ${#RETURN[@]} ]}
        ;;
    *)
        GREETING_TODAY=${GREETINGS[ $RANDOM % ${#GREETINGS[@]} ]}
        ;;
esac

curl -XPOST "${HEADERS[@]}" $RC_URL/api/v1/chat.sendMessage -d'{"message": {"rid":"'"$RC_ROOM"'", "msg":"'"$GREETING_TODAY"'"} }'
