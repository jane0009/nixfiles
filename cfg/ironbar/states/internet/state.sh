#!/usr/bin/env /run/current-system/sw/bin/bash

LOCK="/tmp/internet.lock"
if [ -f "$LOCK" ]; then
  exit 1
else
  exit 0
fi
