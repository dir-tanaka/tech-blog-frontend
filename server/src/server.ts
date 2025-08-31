// my-project/server/src/index.ts

import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';

const app = express();
const port = process.env.PORT || 3000;

// 現在のファイルのパスを取得
const __filename = fileURLToPath(import.meta.url);
// 現在のディレクトリのパスを取得
const __dirname = path.dirname(__filename);

// APIエンドポイントの定義
app.get('/health/service', (req, res) => {
  res.status(200).json({ message: 'Hello from Node.js API!' });
});

// ビルドされたReactアプリの静的ファイルを配信
app.use(express.static(path.join(__dirname, '../../client/dist')));

// API以外のすべてのリクエストに対して、Reactアプリの`index.html`を返す
app.get('/{*any}', (req, res) => {
  res.sendFile(path.join(__dirname, '../../client/dist/index.html'));
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
