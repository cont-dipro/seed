FROM node:15-alpine

WORKDIR /home/app

COPY . .

RUN yarn install

CMD ["yarn", "dev"]