FROM strapi/base:12-alpine

COPY . .
HEALTHCHECK --interval=15s --timeout=5s --start-period=30s CMD node healthcheck.js

EXPOSE 1337

RUN cd strapi-app && rm -rf node_modules && npm install --no-audit && npm run build

CMD ["bash", "./entrypoint.sh"]