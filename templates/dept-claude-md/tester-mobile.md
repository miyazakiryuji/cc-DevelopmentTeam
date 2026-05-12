# tester 部署 — プロジェクト固有メモ (Mobile)

このファイルは tester サブエージェントが起動時に読み込みます。
Mobile 開発のテスト戦略をここに書いてください。

## テストフレームワーク
- iOS ユニット: <XCTest / Swift Testing>
- iOS UI: <XCUITest>
- Android ユニット: <JUnit / Kotest>
- Android UI: <Espresso / Compose UI Test>
- スナップショット: <iOSSnapshotTestCase / Paparazzi / Roborazzi>

## カバレッジ目標
- 最低ライン: <80% など>
- 計測ツール: <Xcode coverage / Kover / JaCoCo>

## テスト実行コマンド
- iOS: `xcodebuild test -scheme <name>`
- Android: `./gradlew test`
- Android インストルメンテーション: `./gradlew connectedAndroidTest`
- スナップショット: `<コマンド>`

## モック方針
- ネットワーク: モックサーバ / OHHTTPStubs / MockWebServer
- DB: インメモリ DB
- 外部依存: protocol / interface でモック注入

## 端末別テスト戦略
- どの iOS / Android バージョンで CI を回すか
- どの画面サイズ・端末でテストするか
- スナップショットテストの対象端末

## E2E / 手動テスト
- どの critical flow を CI の E2E でカバーするか
- 手動テスト対象（ストア審査前チェック等）
