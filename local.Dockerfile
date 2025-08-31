# 開発用Dockerfile
# 開発に必要なツールをすべてインストール
FROM node:20-alpine AS development

WORKDIR /app/client

COPY client/package*.json .
RUN npm ci

# ソースコードをコピー
COPY client/. .
RUN npm run build

WORKDIR /app/server

COPY server/package*.json .
RUN yarn install

# バックエンドのソースコードをコピー
COPY server/. .
RUN npm run build

# Node.jsサーバーを起動
EXPOSE 3000
