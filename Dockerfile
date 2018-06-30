FROM node:10-alpine AS build
WORKDIR /src/realworld
COPY . .
RUN npm set progress=false &&\
  npm config set depth 0 &&\
  npm config set loglevel error &&\
  npm ci || npm i &&\
  npm run build

FROM lkwg82/h2o-http2-server:v2.2.5
COPY --from=build /src/realworld/build/ /var/www/html/
COPY docker/h2o.conf /etc/h2o/h2o.conf
