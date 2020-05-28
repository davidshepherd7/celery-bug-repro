from celery import Celery, bootsteps
from kombu import Consumer, Queue
import time
import logging


logging.basicConfig(level=logging.DEBUG)

logging.info("hello")

app = Celery("tasks", broker="pyamqp://guest@rabbit:5672//")

foo_queue = Queue("foo_events", routing_key="foo_events")


def on_message(message):
    try:
        logging.info(f"got message: {message.delivery_tag}")
        time.sleep(5)
        logging.info(f"handled message: {message.delivery_tag}")
        message.ack()
    except:
        logging.exception("aborted")
        raise


class FooConsumerStep(bootsteps.ConsumerStep):
    def get_consumers(self, channel):
        return [Consumer(channel, queues=[foo_queue], on_message=on_message)]


app.steps["consumer"].add(FooConsumerStep)
