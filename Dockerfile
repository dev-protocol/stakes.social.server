FROM strapi/base:14-alpine as base
WORKDIR /srv/app
COPY package.json /srv/app
COPY yarn.lock /srv/app
RUN yarn install
COPY . .
RUN yarn build && yarn --production

FROM strapi/strapi:3.6.5-alpine
WORKDIR /srv/app
ENV NODE_ENV="production"
COPY --from=base /srv/app .
EXPOSE 1337
CMD ["yarn", "start"]
