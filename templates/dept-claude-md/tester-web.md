# tester 部署 — プロジェクト固有メモ (Web)

このファイルは tester サブエージェントが起動時に読み込みます。
Web 開発のテスト戦略をここに書いてください。

## テストフレームワーク
- ユニット: <Vitest / Jest / pytest / RSpec>
- 統合: <同上 + Testing Library / Django TestCase>
- E2E: <Playwright / Cypress / Selenium>
- コンポーネント単体: <Storybook + interaction tests>

## カバレッジ目標
- 最低ライン: <80% など>
- 計測コマンド: `<コマンド>`

## テスト実行コマンド
- 全体: `<コマンド>`
- 特定ファイル: `<コマンド>`
- ウォッチモード: `<コマンド>`
- E2E: `<コマンド>`

## モック方針
- API: モックサーバ (MSW) / 実 API
- DB: テスト用 DB / インメモリ
- 外部サービス: 必ずモック

## E2E テストの追加ルール
- どの critical path を必ず E2E でカバーするか
- フレイキー対策（リトライポリシー、isolation）

## ブラウザ対応テスト
- どの組み合わせで実行するか（chromium / webkit / firefox）
