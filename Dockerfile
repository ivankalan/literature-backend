FROM node:15
WORKDIR /app
COPY . .
RUN npm install
RUN npm install -g sequelize-cli
EXPOSE 5000
CMD ["node", "server.js"]
