#!/usr/bin/env sh

SELENIUM_VERSION=$1

docker-compose -f selenium-grid.yml up

echo "You can view the grid console here: http://localhost:4444/grid/console"