---
description: cc-DevelopmentTeam プラグインを使い始めるためにプロジェクト側を初期化する
---

このコマンドは Claude Code 内で **このプラグインを初めて使うプロジェクトをセットアップ** するためのものです。長い説明はせず、必要なヒアリングだけ済ませて、初期化が終わってから使い方をご案内します。

最初に必ず以下の **短い導入メッセージ** だけ表示してください（長文の説明は禁止。詳細は最後にまとめて出します）:

```
【プロジェクトの初期化を始めます!】
最初に種別だけ確認させてください! すぐ終わりますよ〜
```

そのまま続けて Step 1 へ進む。

---

## 1. プロジェクト種別のヒアリング（最初に必ず実施）

ユーザーに以下を質問してください:

> このプロジェクトの種別を教えてください。
> - **Web 開発**: ブラウザ・サーバサイド・SPA・SSR など（Next.js, Django, Rails, Express など）
> - **Mobile 開発**: iOS / Android / クロスプラットフォーム（SwiftUI, Jetpack Compose, Flutter, React Native, KMP など）

ユーザーの回答を待ち、その回答を `$PROJECT_TYPE` として保持してください（"Web" または "Mobile"）。
回答が CLI / ライブラリ / その他で迷う場合は「**どちらに近いですか?**」と確認し、近い方を選んでもらってください。

## 2. ドキュメント置き場 + デザイン置き場の作成

以下のディレクトリを作成する（既に存在する場合はスキップ）:

**ドキュメント系:**
- `docs/vision/`（アプリ構想の vision.md / roadmap.md 置き場）
- `docs/basic-design/`（基本設計書 = 全体設計の置き場、プロジェクト全体で 1 ファイル）
- `docs/requirements/`（機能ごとの要件定義書置き場、機能ごとに 1 ファイル）
- `docs/specs/`（機能ごとの詳細仕様書置き場、機能ごとに 1 ファイル）
- `docs/manual-tasks/`（人間が UI 等で操作する必要のあるタスクの管理置き場）

**デザイン系:**
- `design/`（プロジェクト直下。ロゴ・モックアップ・スタイルガイド等のデザイン素材置き場）
- `design/mockups/`（画面モックアップ：Figma エクスポート / PNG / JPG / PDF 等）
- `design/wireframes/`（ワイヤーフレーム）
- `design/assets/`（ロゴ・アイコン・画像素材）

そのうえで、プラグイン同梱のテンプレートを以下にコピーする。**既存ファイルがある場合は上書きしない**:

- プラグインの `templates/vision-template.md` → プロジェクトの `docs/vision/_vision-template.md`
- プラグインの `templates/requirements-template.md` → プロジェクトの `docs/requirements/_template.md`
- プラグインの `templates/basic-design-template.md` → プロジェクトの `docs/basic-design/_template.md`
- プラグインの `templates/spec-template.md` → プロジェクトの `docs/specs/_template.md`
- プラグインの `templates/manual-tasks-template.md` → プロジェクトの `docs/manual-tasks/_template.md`
- プラグインの `templates/design-readme-template.md` → プロジェクトの `design/README.md`

プラグインのテンプレートは、`${CLAUDE_PLUGIN_ROOT}/templates/` 配下を参照するか、もし `CLAUDE_PLUGIN_ROOT` が解決できない場合はプラグインがインストールされているディレクトリの `templates/` を直接読んで内容を `Write` ツールでプロジェクト側に書き出してください（プラグイン側のファイルを移動・改変しないこと）。

## 3. プロジェクトルート CLAUDE.md

プロジェクトルートに `CLAUDE.md` が無ければ作成する。
末尾に以下のセクションが **無ければ追記** する（既にあれば追記しない）。`<種別>` の部分は手順 1 の `$PROJECT_TYPE` で置き換える。

```markdown
## 4部署フロー（cc-development-team プラグイン）

**プロジェクト種別:** <種別>

このプロジェクトは設計/開発/レビュー/テストの4部署 + セキュリティ専門アドバイザー の体制で運用します。

### 主要コマンド

- 何から始めればいいか分からない: `/cc-development-team:guide`（迷ったらこれ）
- アプリ案を相談: `/cc-development-team:brainstorm`
- 仕様書を作成 / 更新: `/cc-development-team:design [name]`
- 開発（develop モード）: `/cc-development-team:develop [name]`
- リファクタ専用: `/cc-development-team:refactor [対象]`
- 現状確認ダッシュボード: `/cc-development-team:status`
- リリース前総合チェック: `/cc-development-team:release-check`
- セキュリティ点検: `/cc-development-team:security-review [name]`
- 仕様書とコードの整合性: `/cc-development-team:sync-spec [name]`
- プラグイン更新手順: `/cc-development-team:update`

仕様書は `docs/specs/<feature-name>.md` に集約します。
設計部署を通さずに実装した場合は、`/cc-development-team:develop` フローの末尾で必ず仕様書が逆同期されます。

部署ごとのプロジェクト固有メモは以下に置きます。各サブエージェントは起動時に自分の CLAUDE.md を読みます。

- 設計部署: `docs/dept/architect/CLAUDE.md`（ドキュメント側）
- 開発部署: `dept/developer/CLAUDE.md`（実作業側）
- レビュー部署: `dept/reviewer/CLAUDE.md`（実作業側）
- テスト部署: `dept/tester/CLAUDE.md`（実作業側）
- セキュリティレビュー部署: `dept/security-reviewer/CLAUDE.md`（実作業側・専門アドバイザー）

セキュリティ専門の点検は `/cc-development-team:security-review` で呼び出せます。
```

## 4. 部署別 CLAUDE.md（5 ファイル）

以下のディレクトリとファイルを作成する。**既に存在するファイルは上書きしない**（ユーザーが書き込んだ内容を尊重する）。
手順 1 で得た `$PROJECT_TYPE` に応じて、各ファイルで **Web 版 または Mobile 版** のテンプレートを 1 つだけ選んで書き込む。

設計部署 (`architect`) のメモは **ドキュメント系**として `docs/dept/` 配下に置き、
実作業を行う 開発 / レビュー / テスト / セキュリティレビュー の 4 部署は **コードや実作業に近い場所**として
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

### 4-5. `dept/security-reviewer/CLAUDE.md`

#### Web の場合

```markdown
# security-reviewer 部署 — プロジェクト固有メモ (Web)

このファイルは security-reviewer サブエージェントが起動時に読み込みます。
Web 開発でのセキュリティ点検観点をここに書いてください。

## 取り扱う個人情報・機密データ
- 個人情報の種類: <氏名 / メール / 住所 / 電話 / 決済情報 / その他>
- 機密データ: <API キー / 内部トークン / 顧客リスト 等>

## 規制・コンプライアンス
- 適用される規制: <個人情報保護法 / GDPR / PCI-DSS / その他>
- 監査・ログ保管要件: <期間・形式>

## 脅威モデル
- 想定される攻撃: <スプレイ / クレデンシャル詰め込み / SSRF / 内部脅威 等>
- 攻撃対象として重視するエンドポイント: <例: /api/auth/*, /api/payments/*>

## 認証・認可
- 認証方式: <セッション / JWT / OAuth>
- セッション/トークンの寿命と更新ポリシー
- 認可ロールの種類: <admin / user / guest など>

## 重視するセキュリティヘッダ
- CSP: <ポリシー>
- HSTS: <max-age 設定>
- その他必須ヘッダ

## 既知の脆弱性 / 対応履歴
- <YYYY-MM-DD: 何があってどう対応したかのログ>

## 依存性管理
- 脆弱性スキャンの実行方法: `npm audit` / `pip-audit` 等
- 依存追加時のチェック観点
```

#### Mobile の場合

```markdown
# security-reviewer 部署 — プロジェクト固有メモ (Mobile)

このファイルは security-reviewer サブエージェントが起動時に読み込みます。
Mobile 開発でのセキュリティ点検観点をここに書いてください。

## 取り扱う個人情報・機密データ
- 個人情報の種類: <氏名 / メール / 住所 / 電話 / 位置情報 / 決済情報 / その他>
- 機密データ: <API キー / 認証トークン / バイオメトリクス 等>

## 規制・コンプライアンス
- 適用される規制: <個人情報保護法 / GDPR / その他>
- ストア審査要件 (App Store / Google Play) の特記事項

## 脅威モデル
- 想定される攻撃: <ジェイルブレイク / ルート化端末からの抽出 / 中間者攻撃 等>
- 守りたい資産: <ローカル DB / Keychain / Keystore に保管している情報>

## 端末ストレージ
- iOS Keychain の使用範囲・accessibility 設定
- Android Keystore の使用範囲
- 平文保存禁止項目

## ネットワーク
- 証明書ピンニング: 有 / 無
- ATS (iOS) / Network Security Config (Android) の設定方針
- 例外ドメイン (許可している http や TLS 弱化)

## App 権限
- 要求する権限: <カメラ / 位置情報 / 連絡先 等> とその justification
- 動的権限取得のタイミング

## ディープリンク / Intent
- 受け付ける scheme / Universal Links / App Links
- パラメータ検証ポリシー
- Android implicit intent / exported activity の方針

## 既知の脆弱性 / 対応履歴
- <YYYY-MM-DD: 何があってどう対応したかのログ>
```

---

## 5. 初期化完了アナウンス（短く）

Step 4 までが完了したら、まず以下を簡潔に表示する:

```
【初期化が完了しました!お疲れさまでした!】
- プロジェクト種別: <$PROJECT_TYPE>
- 作成 / 更新したファイル:
  - <ファイル 1>
  - <ファイル 2>
  ...
```

**`$PROJECT_TYPE = Mobile` の場合は追加で以下を表示:**

```
💡 モバイルアプリ開発の場合、ビルド・シミュレータ起動・実機デバッグは
   専用 IDE から行うのがオススメです!

  - iOS (SwiftUI)            → Xcode (https://developer.apple.com/xcode/)
  - Android (Compose)        → Android Studio (https://developer.android.com/studio)
  - Flutter                  → https://flutter.dev/
  - React Native             → https://reactnative.dev/
  - Kotlin Multiplatform     → https://kotlinlang.org/docs/multiplatform.html

  プロジェクト自体は IDE から開いて、コード編集や仕様書作成は Claude Code、
  という併用が一番ラクです! 詳しくは README の「モバイルアプリ開発の場合は
  専用 IDE 併用がオススメ」をご覧ください。
```

すぐ続けて Step 6 のウェルカム説明に進む（情報を分散させない）。

---

## 6. プラグインの使い方ガイド（初期化完了後に表示）

以下のテキストを **そのまま整形して** ユーザーに表示してください。表 (`|---|`) は Markdown としてそのまま出すこと。

```
【cc-DevelopmentTeam へようこそ!!】

このプラグインは、Claude Code を使った開発を「会社の4部署」みたいに分担させるツールです!
ひとりで開発していても、心の中に 4 人の同僚を持つことができます (孤独感は若干緩和されます!)。

## このプラグインで何ができるの?

以下の 4 部署を順番に呼び出して開発を進めます:

| 部署 | 担当 | 何をしてくれる人? |
| --- | --- | --- |
| architect | 設計部署 | 「何を作るか」を仕様書にまとめてくれる |
| developer | 開発部署 | 仕様書(または依頼)に沿ってコードを書いてくれる |
| reviewer | レビュー部署 | 「ここちょっと危ないですよ」と指摘してくれる(コードは書き換えない) |
| tester | テスト部署 | テストを書いて、実行して、緑になるまで面倒を見てくれる |

加えて専門アドバイザーが 1 人います:

| 部署 | 担当 | 何をしてくれる人? |
| --- | --- | --- |
| security-reviewer | セキュリティ専門アドバイザー | OWASP 観点 / 秘密情報漏れ / 認可漏れ / 依存脆弱性 など、セキュリティに集中して点検。普段は黙っているが、認証・決済・個人情報を扱った後や、リリース前点検で呼ぶと頼れる |

各部署は基本ボランティアで働きます。給料は要りません。但し、たまに人間と同じく勘違いします。

## 主な使い方(段階的に進めていけます)

| 自分の状況 | コマンド | 何が起きる? |
| --- | --- | --- |
| **何から始めればいいか分からない** | **/cc-development-team:guide** | **迷ったらまずこれ**。状況を聞いて次のコマンドを案内 |
| そもそも何を作るか決まってない | /cc-development-team:brainstorm | 雑談ベースでアイデアを 3〜5 個出してくれる |
| アプリ案は決まった、仕様書を作りたい | /cc-development-team:design | architect が呼ばれて仕様書を作って終了(設計だけ) |
| 設計まで終わった、コードを書きたい | /cc-development-team:develop | develop モードに入る。終了するまで連続で開発を回せる |

「何を作ろうかな」状態なら brainstorm → design → develop の順に進むと安心です。
途中から入っても OK (例: 既に作るものが決まってるなら brainstorm はスキップして design から)。
**迷ったら /cc-development-team:guide を実行してください。今の状況に応じて次の一手を教えてくれます。**

## その他のコマンド

| コマンド | 用途 |
| --- | --- |
| /cc-development-team:status | プロジェクトの現状ダッシュボード(進捗・残タスク・次のオススメを表示) |
| /cc-development-team:refactor | リファクタリング専用(既存テスト Before/After を厳守) |
| /cc-development-team:release-check | リリース前の総合チェック + リリースノート自動生成 |
| /cc-development-team:security-review | セキュリティ専門点検(認証/決済/個人情報を扱った後や、リリース前に) |
| /cc-development-team:sync-spec | 仕様書とコードのズレを健康診断 |
| /cc-development-team:update | プラグイン本体を最新版に更新する手順を表示 |
| /cc-development-team:init-dept | この初期化コマンド(再実行も可能) |

## アプリ作りの典型的な進め方

```
[1] 「何作ろうかな…」  →  /cc-development-team:brainstorm    (アイデアを出す)
       ↓ 案が決まった
[2] 「何を作るか整理」  →  /cc-development-team:design        (仕様書を作る)
       ↓ 仕様書ができた
[3] 「コード書きたい」  →  /cc-development-team:develop       (実装する)
```

各ステップは独立して使えるので、既に案がある人は [2] から、設計が手元にある人は [3] からどうぞ。

## ちょっとした補足

- 仕様書は docs/specs/<feature-name>.md に貯まります。後から「何を作ったか」を見返せるので、
  未来の自分が泣いて喜びます。
- 各部署のプロジェクト固有メモは docs/dept/architect/CLAUDE.md と dept/{developer,reviewer,tester,security-reviewer}/CLAUDE.md
  に置かれます。初期テンプレが入っているだけなので、慣れてきたら埋めるとサブエージェントの精度が上がります(空でも動きます)。
- 開発中に「Firebase の設定」「OAuth クライアント登録」など **人間が UI で操作しないと進まないタスク** が出てきたら、
  docs/manual-tasks/<feature-name>.md に自動でまとめられます。仕様書からもリンクされ、関連コードには
  // TODO(manual): ... のコメントが残るので、何を手で設定すべきか後から追えます。
- develop モードから抜けたい時は「終了」「exit」「終わり」のどれかを伝えてください。脱出口は常にあります。
- 詳しい使い方や FAQ は README をご覧ください。
- 部署別の CLAUDE.md は後から自由に編集できます。種別 (Web / Mobile) を変えたい場合は、各 CLAUDE.md
  を直接書き換えるか、削除してから /cc-development-team:init-dept を再実行してください。

それでは、楽しい開発を!! 何か困ったら /cc-development-team:guide でいつでも相談できます!
```

ウェルカム説明を出し終えたら、コマンドはこれで終了。ユーザーが次のアクションを取れる状態で待機する。
