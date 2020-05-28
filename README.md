
Reproduction of worker aborting tasks during a warm shutdown only when using a custom consumer and prefork.

```
docker build . -t david/celery-experiment
docker-compose up # in a separate terminal so that you can see the logs
./setup-rabbit.sh

# Wait until celery is ready

docker exec -it rabbit rabbitmqadmin publish routing_key=foo_events payload='foo2' && sleep 1 && docker stop celery


# Uncomment the line in docker-compose to use gevent and repeat to see the desired behaviour
```
