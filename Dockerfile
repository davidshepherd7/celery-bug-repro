FROM python:3.7-alpine
RUN apk add gcc musl-dev linux-headers make libffi-dev git \
    && pip3 install --upgrade git+https://github.com/celery/celery.git@master gevent
COPY tasks.py /
CMD celery -A tasks worker
