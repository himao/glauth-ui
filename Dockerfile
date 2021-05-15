FROM python:3.8-alpine

WORKDIR /glauthui

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn

COPY app app
COPY migrations migrations
COPY ldap.py config.py boot.sh ./
RUN set -x \
 && chmod +x boot.sh \
 && mkdir -p /glauthui/db

ENV FLASK_APP ldap.py

VOLUME ["/glauthui/db"]

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
