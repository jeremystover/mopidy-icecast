#!/bin/sh

icecast2 -b -c icecast.xml

# Hand off to the CMD
exec "$@"
