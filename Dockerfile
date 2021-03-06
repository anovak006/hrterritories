FROM python:3.6-alpine

RUN apk update \
  && apk add --virtual build-deps gcc python3-dev musl-dev \
  && apk add postgresql-dev \
  && pip install psycopg2 \
  && apk add --no-cache python3-dev libstdc++ \
  && apk add --no-cache --virtual .build-deps g++ \
  && ln -s /usr/include/locale.h /usr/include/xlocale.h \
  && apk add build-base linux-headers pcre-dev

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY ./requirements.txt /usr/src/app
RUN pip install -r requirements.txt

ENV PYTHONUNBUFFERED 1

# COPY ./main.py /usr/src/app/.
# COPY ./hrterritories /usr/src/app/hrterritories
# COPY ./tests /usr/src/app/tests
COPY . /usr/src/app/.
