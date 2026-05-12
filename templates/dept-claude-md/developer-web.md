# developer 部署 — プロジェクト固有メモ (Web)

このファイルは developer サブエージェントが起動時に読み込みます。
Web 開発のコーディング規約・実装パターンをここに書いてください。

## 技術スタック
- 言語: <TypeScript / JavaScript / Python / Go など>
- フレームワーク: <Next.js / Django / Rails など>
- データベース: <PostgreSQL / MySQL / MongoDB など>
- ORM / Query Builder: <Prisma / Drizzle / TypeORM / Django ORM など>
- パッケージマネージャ: <npm / pnpm / yarn / pip / bundle>

## コーディング規約
- フォーマッタ: <Prettier / Black / gofmt>
- リンタ: <ESLint / Ruff / golangci-lint>
- 型チェック: <tsc --strict / mypy>
- 命名規約: <camelCase / snake_case 等>

## 実装パターン
- コンポーネント分割の方針（server / client / shared）
- API クライアントの統一実装
- エラーバウンダリ
- フォームバリデーション
- 認証 / 認可の組み込み方

## ビルド・実行コマンド
- 開発サーバ起動: `<コマンド>`
- ビルド: `<コマンド>`
- 型チェック: `<コマンド>`
- リント: `<コマンド>`
- フォーマット: `<コマンド>`

## 依存追加のルール
- 新規依存追加時の判断基準（バンドルサイズ・メンテナンス状況）
- 利用禁止のライブラリ
