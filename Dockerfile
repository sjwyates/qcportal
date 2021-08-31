# pull official base image
FROM python:3.9.6-alpine3.13

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

# set working directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# add/switch to non-root user
RUN addgroup app && adduser -S -G app app
USER app

# copy project
COPY . .

# declare port
EXPOSE 8000