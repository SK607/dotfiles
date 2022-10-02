#!/usr/bin/env bash

if [[ "$(expressvpn status)" = 'Not connected' ]]; then
    expressvpn connect smart
else
    expressvpn disconnect
fi

