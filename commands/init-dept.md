---
description: cc-DevelopmentTeam プラグインを使い始めるためにプロジェクト側を初期化する
---

このプロジェクトを 4 部署フローで運用するために、以下を順に実行してください。

## 1. プロジェクト種別のヒアリング（最初に必ず実施）

ユーザーに以下を質問してください:

> このプロジェクトの種別を教えてください。
> - **Web 開発**: ブラウザ・サーバサイド・SPA・SSR など（Next.js, Django, Rails, Express など）
> - **Mobile 開発**: iOS / Android / クロスプラットフォーム（SwiftUI, Jetpack Compose, Flutter, React Native, KMP など）

ユーザーの回答を待ち、その回答を `$PROJECT_TYPE` として保持してください（"Web" または "Mobile"）。
回答が CLI / ライブラリ / その他で迷う場合は「**どちらに近いですか?**」と確認し、近い方を選んでもらってください。

## 2. 仕様書ディレクトリとアプリ構想ディレクトリ

以下のディレクトリを作成する（既に存在する場合はスキップ）:

- `docs/specs/`（個別機能の仕様書置き場）
- `docs/vision/`（アプリ構想の vision.md / roadmap.md 置き場）

そのうえで、プラグイン同梱のテンプレートを以下にコピーする。**既存ファイルがある場合は上書きしない**:

- プラグインの `templates/spec-template.md` → プロジェクトの `docs/specs/_template.md` にコピー
- プラグインの `templates/vision-template.md` → プロジェクトの `docs/vision/_vision-template.md` にコピー

プラグインのテンプレートは、`${CLAUDE_PLUGIN_ROOT}/templates/` 配下を参照するか、もし `CLAUDE_PLUGIN_ROOT` が解決できない場合はプラグインがインストールされているディレクトリの `templates/` を直接読んで内容を `Write` ツールでプロジェクト側に書き出してください（プラグイン側のファイルを移動・改変しないこと）。

## 3. プロジェクトルート CLAUDE.md

プロジェクトルートに `CLAUDE.md` が無ければ作成する。
末尾に以下のセクションが **無ければ追記** する（既にあれば追記しない）。`<種別>` の部分は手順 1 の `$PROJECT_TYPE` で置き換える。

```markdown
## 4部署フロー（cc-development-team プラグイン）

**プロジェクト種別:** <種別>

このプロジェクトは設計/開発/レビュー/テストの4部署体制で運用します。

- 設計（仕様書作成）: `/cc-development-team:design <name>`
- アプリ構想から始める: `/cc-development-team:design`（引数なしで起動）
- 開発先行（back-fill 付き）: `/cc-development-team:develop <name>`
- 整合性チェック: `/cc-development-team:sync-spec`

仕様書は `docs/specs/<feature-name>.md` に集約します。
設計部署を通さずに実装した場合は、`/cc-development-team:develop` フローの末尾で必ず仕様書が逆同期されます。

部署ごとのプロジェクト固有メモは以下に置きます。各サブエージェントは起動時に自分の CLAUDE.md を読みます。

- 設計部署: `docs/dept/architect/CLAUDE.md`（ドキュメント側）
- 開発部署: `dept/developer/CLAUDE.md`（実作業側）
- レビュー部署: `dept/reviewer/CLAUDE.md`（実作業側）
- テスト部署: `dept/tester/CLAUDE.md`（実作業側）
```

## 4. 部署別 CLAUDE.md（4 ファイル）

以下のディレクトリとファイルを作成する。**既に存在するファイルは上書きしない**（ユーザーが書き込んだ内容を尊重する）。
手順 1 で得た `$PROJECT_TYPE` に応じて、各ファイルで **Web 版 または Mobile 版** のテンプレートを 1 つだけ選んで書き込む。

設計部署 (`architect`) のメモは **ドキュメント系**として `docs/dept/` 配下に置き、
実作業を行う開発/レビュー/テストの 3 部署は **コードや実作業に近い場所**として
プロジェクトルート直下の `dept/` 配下に置く方針です。

---

### 4-1. `docs/dept/architect/CLAUDE.md`

#### Web の場合

```markdown
# architect 部署 — プロジェクト固有メモ (Web)

このファイルは architect サブエージェントが起動時に読み込みます。
Web 開発向けの設計判断ガイドをここに書いてください。

## プロジェクト概要
- 種別: Web
- フロントエンド / バックエンド / フルスタック: <埋める>
- 主要フレームワーク: <Next.js / Nuxt / Django / Rails / Express など>
- 言語: <TypeScript / Python / Go / Ruby など>

## アーキテクチャ方針
- レンダリング戦略: <SPA / SSR / SSG / ISR>
- コンポーネント設計の方針（Atomic / Feature-based 等）
- データフロー / 状態管理（Redux / Zustand / React Query 等）
- API 設計: <REST / GraphQL / tRPC>
- 認証方式: <セッション / JWT / OAuth>

## ドメイン用語集
- ドメイン固有の語彙と定義

## 非機能要件
- 性能: 初期表示時間・API レスポンスタイム目標
- アクセシビリティ: WCAG 準拠レベル
- ブラウザ対応: Chrome / Safari / Edge / Firefox の最小バージョン
- セキュリティ: OWASP 重点項目（XSS / CSRF / SQL injection 等）
- SEO 要件: 必要な範囲

## 設計判断の前例集
- 過去に下した重要な設計判断と、その理由
```

#### Mobile の場合

```markdown
# architect 部署 — プロジェクト固有メモ (Mobile)

このファイルは architect サブエージェントが起動時に読み込みます。
Mobile 開発向けの設計判断ガイドをここに書いてください。

## プロジェクト概要
- 種別: Mobile
- プラットフォーム: <iOS / Android / クロスプラットフォーム>
- 主要フレームワーク: <SwiftUI / UIKit / Jetpack Compose / Flutter / React Native / KMP>
- 言語: <Swift / Kotlin / Dart など>

## サポート対象
- iOS 最小バージョン: <iOS 16 など>
- Android 最小 API レベル: <API 26 など>
- 端末対応: 画面サイズ・縦横切替・ダークモード

## アーキテクチャ方針
- パターン: <MVVM / MVI / TCA / Clean Architecture>
- ナビゲーション: <NavigationStack / Jetpack Navigation / Coordinator>
- 状態管理: <Observable / Flow / Compose State>
- DI: <Hilt / Koin / Swinject / 手書き>

## ドメイン用語集
- ドメイン固有の語彙と定義

## 非機能要件
- 性能: 起動時間（cold start）、画面遷移、FPS 目標
- アクセシビリティ: VoiceOver / TalkBack 対応、Dynamic Type
- オフライン対応: 必要な範囲、データキャッシュ戦略
- 通知: Push 通知の利用範囲、バックグラウンド処理
- セキュリティ: Keychain / Keystore の使い方、証明書ピンニング、難読化
- ストア対応: App Store / Play Store の審査ガイドライン上の留意点

## 設計判断の前例集
- 過去に下した重要な設計判断と、その理由
```

---

### 4-2. `dept/developer/CLAUDE.md`

#### Web の場合

```markdown
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
```

#### Mobile の場合

```markdown
# developer 部署 — プロジェクト固有メモ (Mobile)

このファイルは developer サブエージェントが起動時に読み込みます。
Mobile 開発のコーディング規約・実装パターンをここに書いてください。

## 技術スタック
- 言語: <Swift / Kotlin / Dart>
- UI フレームワーク: <SwiftUI / UIKit / Jetpack Compose / Flutter>
- DI: <Hilt / Koin / Swinject など>
- 非同期: <async/await / Coroutines / RxSwift・RxJava>
- 永続化: <Core Data / SwiftData / Room / Realm>
- ネットワーク: <URLSession / Retrofit / Ktor Client / Alamofire>

## コーディング規約
- フォーマッタ: <swift-format / ktlint>
- リンタ: <SwiftLint / detekt>
- 命名規約: 言語標準に従う

## 実装パターン
- View 層のスタイル（SwiftUI / Compose の慣習）
- ViewModel 層の責務範囲
- 状態管理（UIState / @Published / StateFlow）
- 依存性注入のパターン
- エラーハンドリング（Result 型 / sealed class）

## ビルド・実行コマンド
- iOS ビルド: `xcodebuild -scheme <name> build`
- iOS シミュレータ実行: Xcode から、または `xcrun simctl`
- Android ビルド: `./gradlew assembleDebug`
- Android 実行: `./gradlew installDebug`
- 静的解析: `<コマンド>`

## 端末・OS 対応
- 最小サポートバージョン
- iPad / タブレット対応の必要性
- ランドスケープ対応
- ダークモード対応
```

---

### 4-3. `dept/reviewer/CLAUDE.md`

#### Web の場合

```markdown
# reviewer 部署 — プロジェクト固有メモ (Web)

このファイルは reviewer サブエージェントが起動時に読み込みます。
Web 開発でのレビュー観点をここに書いてください。

## このプロジェクトで必ず見る観点

### セキュリティ
- 入力バリデーション（XSS / SQL injection / Command injection）
- 認証・認可の漏れ（URL 直叩きで認可をバイパスできないか）
- 秘密情報のクライアント露出（環境変数の漏れ）
- CORS / CSP の設定
- セッション・Cookie の属性（Secure / HttpOnly / SameSite）

### 性能
- N+1 クエリ
- 不必要な re-render
- バンドルサイズの肥大化
- 画像・アセットの最適化
- キャッシュ戦略（CDN / HTTP / クライアント）

### アクセシビリティ
- セマンティック HTML
- キーボード操作
- aria 属性
- コントラスト比

## severity 判定の調整
- Critical: 認証・認可バイパス、SQL injection、XSS、秘密情報の漏洩
- High: N+1 クエリ、エラーハンドリング欠落、a11y 違反
- Medium: 命名・構造・小規模なバグ
- Low: スタイル・好み

## レビューで使う追加チェックリスト
- API レスポンスのキャッシュ戦略
- リトライ可能性（べき等性）
- ロギング・モニタリングの観点
```

#### Mobile の場合

```markdown
# reviewer 部署 — プロジェクト固有メモ (Mobile)

このファイルは reviewer サブエージェントが起動時に読み込みます。
Mobile 開発でのレビュー観点をここに書いてください。

## このプロジェクトで必ず見る観点

### セキュリティ
- 秘密情報の埋め込み（API キー・証明書のハードコード禁止）
- Keychain / Keystore の正しい使い方
- 証明書ピンニング
- ATS (iOS) / Network Security Config (Android)

### メモリ・性能
- リテイン サイクル / 循環参照
- メインスレッドでの重い処理
- リーク
- 過剰な再コンポジション (Compose) / 再描画 (SwiftUI)

### ライフサイクル
- View / ViewModel のライフサイクル整合性
- バックグラウンド遷移時の状態保存
- プロセスキル後の復元

### アクセシビリティ
- VoiceOver / TalkBack ラベル
- Dynamic Type 対応
- コントラスト比

### ストア審査
- 必要な権限（camera / location / contacts）の justification
- プライバシーマニフェスト (iOS)
- ターゲット SDK バージョン要件 (Android)

## severity 判定の調整
- Critical: 秘密情報埋め込み、無認可のデータアクセス、クラッシュバグ、ストア審査拒否要因
- High: メモリリーク、メインスレッドブロック、a11y 違反
- Medium: 命名・構造・パフォーマンス改善余地
- Low: スタイル・好み

## レビューで使う追加チェックリスト
- バックグラウンド時の挙動
- 通知タップからの起動経路
- 異なる画面サイズ・回転での見え方
```

---

### 4-4. `dept/tester/CLAUDE.md`

#### Web の場合

```markdown
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
```

#### Mobile の場合

```markdown
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
```

---

## 5. ユーザーへの案内

完了後、以下を簡潔に案内する:

- 選択された `$PROJECT_TYPE` (Web / Mobile)
- 作成/更新したファイル一覧
- `/cc-development-team:design <name>` で設計フローを起動（仕様書のみ作成・実装は別途）
- `/cc-development-team:develop <name>` で開発先行フロー（back-fill 付き）
- `/cc-development-team:sync-spec [name]` で整合性チェック
- 部署別の CLAUDE.md を埋めるとサブエージェントの精度が上がる旨を一言伝える
- 後から種別を切り替えたい場合は、対応する `CLAUDE.md` を手動で書き換える（または各ファイルを削除して `init-dept` を再実行する）旨を伝える
