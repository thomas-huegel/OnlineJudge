FROM python:3.7-alpine3.9

ENV OJ_ENV production

ADD . /app
WORKDIR /app

HEALTHCHECK --interval=5s --retries=3 CMD python2 /app/deploy/health_check.py

RUN apk add --update --no-cache build-base git nginx openssl supervisor jpeg-dev zlib-dev postgresql-dev freetype-dev && \
    pip install --no-cache-dir -r /app/deploy/requirements.txt && \
    apk del build-base --purge

RUN git clone https://github.com/thomas-hugel/OnlineJudgeFE.git; \
    mv OnlineJudgeFE/dist ./; \
    rm -rf OnlineJudgeFE

ENTRYPOINT /app/deploy/entrypoint.sh
