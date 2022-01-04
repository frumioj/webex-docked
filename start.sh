#!/bin/bash
set -e
set -o pipefail

su user -p -c "/opt/Webex/bin/CiscoCollabHost"

# don't like this, but maybe this is what is needed to stop immediate
# exit of main process?
tail -f /dev/null
#while true; do sleep 1000; done
