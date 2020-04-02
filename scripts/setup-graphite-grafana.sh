#!/usr/bin/env sh

docker network create graphite_grafana

docker run -d \
 --name graphite \
 --restart=always \
 --net graphite_grafana \
 -p 80:80 \
 -p 2003-2004:2003-2004 \
 -p 2023-2024:2023-2024 \
 -p 8125:8125/udp \
 -p 8126:8126 \
 graphiteapp/graphite-statsd

docker run -d --name=grafana -p 3000:3000 --net graphite_grafana grafana/grafana

echo "All done - access details:"
echo "Grafana UI: http://localhost:3000"
echo "Graphite UI: http://localhost:80"
