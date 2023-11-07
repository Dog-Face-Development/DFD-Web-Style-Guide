# syntax=docker/dockerfile:1

FROM node:lts AS build
WORKDIR /app
COPY . .
RUN npm i --force
RUN npm audit fix --force
RUN npm run build

FROM httpd:2.4 AS runtime
COPY --from=build /app/dist /usr/local/apache2/htdocs/
EXPOSE 80
