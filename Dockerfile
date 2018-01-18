# Have to use node 7 as there is no pre-build binary binding for SQLite 3
# ref: https://github.com/mapbox/node-sqlite3/blob/master/appveyor.yml
FROM node:7-alpine

ENV RESTBASE_VERSION v0.17.0

EXPOSE 7231

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

RUN apk add --no-cache git \
    && npm install -g --only=production restbase@${RESTBASE_VERSION} restbase-mod-table-sqlite \
    && npm cache clean --force \
    && rm -rf /tmp/npm* /root/.node* /root/.npm

CMD ["node", "/usr/local/lib/node_modules/restbase/server.js", "--config=/config.yaml"]
