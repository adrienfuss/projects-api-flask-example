# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

ARG FLASK_GID=1000
ARG FLASK_UID=1000
ARG FLASK_HOME=/app

USER root
WORKDIR ${FLASK_HOME}
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt


RUN groupadd -g "${FLASK_GID}" "flask" \
    && useradd -u "${FLASK_UID}" "flask" -g "flask" \
    && chown -R ${FLASK_UID}:${FLASK_GID} ${FLASK_HOME}

USER flask
COPY --chown=flask:flask app.py app.py

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
