#!/bin/bash -eu

set -o pipefail

# Portably go to the directory that this script is in
cd "$(dirname ${BASH_SOURCE[0]})"

docker exec -it rabbit apk update
docker exec -it rabbit apk add python
docker exec -it rabbit rabbitmq-plugins enable rabbitmq_management
docker exec -it rabbit wget 'http://localhost:15672/cli/rabbitmqadmin' -O /bin/rabbitmqadmin
docker exec -it rabbit chmod +x /bin/rabbitmqadmin

echo "publish events with: docker exec -it rabbit rabbitmqadmin publish routing_key=foo_events payload='foo'"
