FROM python:3.7-alpine
RUN apk add gcc musl-dev linux-headers make libffi-dev \
    && pip3 install --upgrade celery gevent
COPY tasks.py /
CMD celery -A tasks worker
