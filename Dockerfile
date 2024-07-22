FROM node:18.15.0 as builder

WORKDIR /usr/src/app

COPY package*.json ./

COPY tsconfig*.json ./

COPY src src

RUN npm ci 

RUN npm run build


FROM node:18.15-alpine

WORKDIR /usr/src/app

COPY package*.json ./

COPY tsconfig*.json ./

RUN npm install --production

COPY --from=builder /usr/src/app/dist ./dist

EXPOSE 3000

CMD ["node", "/usr/src/app/dist/main.js"]