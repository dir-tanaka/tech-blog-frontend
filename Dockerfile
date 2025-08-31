FROM node:20-alpine AS frontend-builder

# 作業ディレクトリを /app/client に設定
WORKDIR /app/client

# package.jsonとpackage-lock.jsonをコピー
COPY client/package*.json ./

# 依存関係をインストール
RUN npm install

# ソースコードをコピー
COPY client/. .

# Viteで本番用ビルドを実行
RUN npm run build

#--

# 軽量なNode.jsイメージをベースにする
FROM node:20-alpine AS app

# 作業ディレクトリを /app/server に設定
WORKDIR /app/server

# package.jsonとpackage-lock.jsonをコピー
COPY server/package.json ./
COPY server/yarn.lock ./
COPY server/tsconfig.json ./

# 本番環境用の依存関係をインストール
RUN yarn install

# バックエンドのソースコードをコピー
COPY server/. .
RUN npm run build

# 1つ目のステージでビルドしたフロントエンドの成果物をコピー
# /app/server/dist/client に配置
COPY --from=frontend-builder /app/client/dist /app/client/dist

# Node.jsサーバーを起動
EXPOSE 3000

CMD ["npm", "run", "start", "./dist/server.js"]