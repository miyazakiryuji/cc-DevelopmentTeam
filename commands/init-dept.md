---
description: cc-DevelopmentTeam プラグインを使い始めるためにプロジェクト側を初期化する
---

このコマンドは Claude Code 内で **このプラグインを初めて使うプロジェクトをセットアップ** するためのものです。長い説明はせず、必要なヒアリングだけ済ませて、初期化が終わってから使い方をご案内します。

最初に必ず以下の **短い導入メッセージ** だけ表示してください（長文の説明は禁止。詳細は最後にまとめて出します）:

```
【プロジェクトの初期化を始めます!】
最初に 3 つだけ確認させてください! 1) 種別 / 2) 設計思想 / 3) アプリコードの置き場所
分からなければ「お任せ」で OK です〜
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

## 2. 設計思想のヒアリング（こちらから候補を提示）

`$PROJECT_TYPE` に応じて、設計思想（アーキテクチャパターン）の候補をユーザーに提示する。**ユーザーから自由記述させず、こちらから 3〜4 個提案** すること。特にこだわりが無ければ a) お任せでサクッと進めて OK と伝える。

### Web の場合

```
【設計思想を選んでください】
今回のプロジェクトはどの設計思想で組み立てますか?
特にこだわりが無ければ a) お任せで進めますよ〜

a) お任せ (Feature-based + 軽量レイヤ分け、推奨)
   → 機能ごとにフォルダを切る現代的構成。中規模までスケールしやすい
b) MVC (Rails / Django / Express など)
   → 伝統的な Model / View / Controller 分離
c) Clean Architecture / Layered
   → domain / data / presentation の厳密なレイヤ分け。大規模 / 長期保守向け
d) その他 (自分で指定する)
```

### Mobile の場合

```
【設計思想を選んでください】
今回のプロジェクトはどの設計思想で組み立てますか?
特にこだわりが無ければ a) お任せで進めますよ〜

a) お任せ (MVVM + Feature module、推奨)
   → ViewModel + 機能モジュールの組み合わせ。SwiftUI / Compose / Flutter 共通の現代的構成
b) Clean Architecture
   → UseCase / Repository / Entity の厳密分離。大規模 / 長期保守向け
c) MVI / TCA / Redux 系
   → Intent / State 駆動。状態管理を厳密にしたい場合
d) その他 (自分で指定する)
```

回答を `$ARCHITECTURE` として保持。`d)` を選ばれた場合は自由記述を受け取り、その内容をそのまま保持。

## 3. アプリコード配置のヒアリング（こちらから候補を提示）

実装するアプリコードのルートフォルダを `$PROJECT_TYPE` に応じて候補提示する。

### Web の場合

```
【アプリコードはどのフォルダに置きますか?】
実装するソースコードのルートを教えてください。

a) src/ (推奨: React / Next.js / Vite / 多くの Node 系の慣習)
b) app/ (Rails / Django / Next.js App Router)
c) apps/ + packages/ (Monorepo 構成)
d) その他 (自分で指定: 例えば server/ や backend/ など)
```

### Mobile の場合

```
【アプリコードはどのフォルダに置きますか?】
実装するソースコードのルートを教えてください。

a) lib/ (推奨: Flutter の慣習)
b) shared/ + ios/ + android/ (KMP / React Native のクロスプラットフォーム)
c) <AppName>/ (iOS native: Xcode プロジェクト直下)
d) app/src/main/ (Android native: Gradle 慣習)
e) その他 (自分で指定)
```

回答のルートフォルダパスを `$APP_ROOT` として保持（複数フォルダの場合は配列）。

## 4. ヒアリング内容のサマリ確認

3 つのヒアリング結果を 1 メッセージにまとめて確認:

```
【ここまでの選択を確認させてください】

- プロジェクト種別: $PROJECT_TYPE
- 設計思想: $ARCHITECTURE
- アプリコード配置: $APP_ROOT

このまま初期化を進めて OK ですか? (変更したい項目があれば言ってください!)
```

ユーザーの確認が取れたら Step 5 へ。

## 5. ドキュメント置き場 + デザイン置き場 + アプリコード置き場の作成

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

**アプリコード系（$APP_ROOT + $ARCHITECTURE に応じて作る）:**

`$APP_ROOT` のルートフォルダを作成し、その配下に `$ARCHITECTURE` に応じたサブフォルダを切る。

#### Web の場合

| $ARCHITECTURE | サブフォルダ構成 (例: $APP_ROOT が `src/` の場合) |
| --- | --- |
| a) お任せ (Feature-based) | `src/features/`, `src/shared/`, `src/components/`, `src/lib/` |
| b) MVC | `src/models/`, `src/views/`, `src/controllers/`, `src/services/` |
| c) Clean Architecture | `src/domain/`, `src/data/`, `src/presentation/`, `src/core/` |
| d) その他 | 自由記述に基づいて妥当な構成を提案し、ユーザー確認を取ってから作成 |

`$APP_ROOT` が `apps/ + packages/` (Monorepo) の場合は、`apps/<app-name>/` と `packages/shared/` を作り、`apps/<app-name>/` 配下に上記サブフォルダを切る（app-name はユーザーに確認）。

#### Mobile の場合

| $ARCHITECTURE | サブフォルダ構成 (例: $APP_ROOT が `lib/` の場合) |
| --- | --- |
| a) お任せ (MVVM + Feature module) | `lib/features/`, `lib/shared/`, `lib/core/` |
| b) Clean Architecture | `lib/domain/`, `lib/data/`, `lib/presentation/`, `lib/core/` |
| c) MVI / TCA / Redux 系 | `lib/features/`, `lib/shared/`, `lib/core/`（features 配下に state/reducer/view を置く方針） |
| d) その他 | 自由記述に基づいて妥当な構成を提案し、ユーザー確認を取ってから作成 |

`$APP_ROOT` が `<AppName>/` (iOS native) の場合は Xcode が生成するファイル構成を尊重し、追加で `<AppName>/Features/`, `<AppName>/Shared/`, `<AppName>/Core/` のみ作成。

`$APP_ROOT` が `app/src/main/` (Android native) の場合は Gradle 構成を尊重し、追加で `app/src/main/kotlin/<package>/features/`, `.../shared/`, `.../core/` を作成（package 名はユーザーに確認）。

> **既存フォルダがある場合は上書きしない**こと。空のフォルダだけ追加する。
>
> **既にコードが入っている**プロジェクトに init-dept を後付けする場合は、フォルダを新規作成せず「既存の構造を維持」する旨をユーザーに伝え、`$ARCHITECTURE` の選択は CLAUDE.md への記述だけにとどめる。次の Step 5.5 で「移動を提案するか」を判断する。

### 5.5 既存ファイル / フォルダの再配置提案（既存コードがある場合のみ）

新しいフォルダ構成を作った後、既存のソースが新構成と整合していない場合、**移動可能なものだけを提案** する。**自動移動は絶対にしない**。必ずユーザー承認を取り、承認されたものだけ `mv` で移動する。

#### 5.5-1: 検出

`Glob` でプロジェクト全体のソースファイル (`*.{ts,tsx,js,jsx,vue,svelte,swift,kt,dart,py,rb,go,rs}` 等、`$PROJECT_TYPE` に応じて) を列挙し、以下を抽出:

- `$APP_ROOT` の外にある、コードらしきファイル
- 旧構造のフォルダ（例: ルート直下に `views/`, `controllers/`, `components/`, `utils/` などがあり、新構成 (`src/features/` 等) と重複しているもの）
- `$APP_ROOT` 内でも、新しいサブフォルダ ($ARCHITECTURE 由来) と矛盾する位置にあるもの

何も該当しなければ Step 5.5 全体をスキップして Step 6 へ。

#### 5.5-2: 安全性の判定（移動前に必ずチェック）

検出した各ファイル / フォルダについて、以下を `Grep` で確認:

- **import / require 参照**: 他ファイルから `import .* from "<path>"` 等で参照されているか
- **ビルド設定参照**: `tsconfig.json`, `vite.config.*`, `webpack.config.*`, `package.json` (scripts 内のパス), `*.xcodeproj/project.pbxproj`, `build.gradle*`, `settings.gradle*`, `Package.swift`, `pubspec.yaml`, `pyproject.toml`, `Cargo.toml` などでパスが参照されているか
- **エントリポイント**: `main.*`, `index.*`, `App.swift`, `MainActivity.kt`, `_app.tsx`, `+layout.svelte` などのファイル

判定:

| 種類 | 自動移動の可否 |
| --- | --- |
| 参照ゼロ、ビルド設定にも未登場 | **提案 OK** (ユーザー承認後に `mv`) |
| import 参照あり (相対パスのみで、書き換え数 5 以内) | **提案 OK** だが「import 書き換えも実施します」と明記してユーザー確認 |
| import 参照あり (6 件以上) | **提案するが自動移動はしない**。手動対応を案内 |
| ビルド設定参照あり | **提案するが自動移動はしない**。手動対応を案内 |
| エントリポイント | **提案するが自動移動はしない**。手動対応を案内 |

#### 5.5-3: ユーザーへの提案

以下のフォーマットでまとめて提示:

```
【既存ファイル / フォルダの再配置提案】
新しい構成に合わせて、以下の移動を提案します。
※ 破壊的な変更 (ビルドが壊れるもの) は提案だけで、自動移動はしません。

■ 自動で移動できるもの (参照少、安全):
- old/utils/format.ts → src/lib/format.ts
- old/components/Header.tsx → src/components/Header.tsx (import を 2 箇所書き換えます)

■ 提案のみ (手動対応推奨):
- src/index.ts → src/app/index.ts
  → エントリポイントのため、tsconfig.json の paths 書き換えが必要。手動でお願いします
- views/ フォルダ
  → 8 ファイルが他から import されており、import 書き換えが多いため手動推奨

進め方を選んでください:
a) 自動移動できるものを全部移動する
b) 移動するものを 1 つずつ確認する
c) どれも移動しない (現状維持)
```

#### 5.5-4: 移動の実行

- `a)` 選択 → 「自動で移動できるもの」リストを一括で `Bash` の `mv` で移動。import 参照の書き換えが必要なものは `Edit` で書き換え
- `b)` 選択 → 1 ファイルずつ「これ移動しますか?」と確認しながら進める
- `c)` 選択 → 何もせず Step 6 へ
- 「提案のみ」分は **自動移動しない**。`docs/manual-tasks/initial-restructure.md` に手順を書き出して追跡可能にする

移動完了後、軽く動作確認を促す:

```
移動しました!
念のため、軽くビルドだけ通るか確認しておくと安心です:
- <推定ビルドコマンド>

何か壊れていそうなら、すぐ Claude に教えてください。直します!
```

#### 共通ルール (Step 5.5 以外の全工程にも適用)

**このプラグインの全エージェント / 全コマンドに共通**:

- **破壊的な変更は絶対に自動実行しない**。ビルド / 既存テスト / 動作確認が通らなくなる可能性がある変更 (import 書き換えを伴うファイル移動・削除・リネーム、ビルド設定変更、エントリポイントの移動など) は、必ずユーザー承認を取り、承認された範囲のみ実施する
- 「念のため」「とりあえず」での移動 / 削除 / リネームは禁止。明確に安全と確認できるもののみ
- 不確実な場合は提案にとどめ、`docs/manual-tasks/` に書き出して手動対応に回す

そのうえで、プラグイン同梱のテンプレートを以下にコピーする。**既存ファイルがある場合は上書きしない**:

- プラグインの `templates/vision-template.md` → プロジェクトの `docs/vision/_vision-template.md`
- プラグインの `templates/requirements-template.md` → プロジェクトの `docs/requirements/_template.md`
- プラグインの `templates/basic-design-template.md` → プロジェクトの `docs/basic-design/_template.md`
- プラグインの `templates/spec-template.md` → プロジェクトの `docs/specs/_template.md`
- プラグインの `templates/manual-tasks-template.md` → プロジェクトの `docs/manual-tasks/_template.md`

各フォルダの使い方は本プラグインの `guides/directory-structure.md`（プラグインリポジトリ内）に記載があります。プロジェクト側に README は作成しません（ルートの `CLAUDE.md` 以外、各フォルダに案内ファイルは置かない方針）。

プラグインのテンプレートは、`${CLAUDE_PLUGIN_ROOT}/templates/` 配下を参照するか、もし `CLAUDE_PLUGIN_ROOT` が解決できない場合はプラグインがインストールされているディレクトリの `templates/` を直接読んで内容を `Write` ツールでプロジェクト側に書き出してください（プラグイン側のファイルを移動・改変しないこと）。

## 6. プロジェクトルート CLAUDE.md

プロジェクトルートに `CLAUDE.md` が無ければ作成する。
末尾に以下のセクションが **無ければ追記** する（既にあれば追記しない）。`<種別>`, `<設計思想>`, `<アプリコード配置>` はそれぞれ `$PROJECT_TYPE`, `$ARCHITECTURE`, `$APP_ROOT` で置き換える。

```markdown
## 4部署フロー（cc-development-team プラグイン）

**プロジェクト種別:** <種別>
**設計思想:** <設計思想>
**アプリコード配置:** <アプリコード配置>

このプロジェクトは設計/開発/レビュー/テストの4部署 + セキュリティ専門アドバイザー の体制で運用します。
新規ファイルを追加する際は、上記の「設計思想」と「アプリコード配置」に従ったフォルダに配置してください。

### 共通ルール: 破壊的な変更は絶対にしない

このプロジェクトで動く **全エージェント / 全コマンドに共通** のルール:

- ビルド / 既存テスト / 動作確認が通らなくなる可能性がある変更 (import 書き換えを伴うファイル移動・削除・リネーム、ビルド設定変更、エントリポイントの移動 等) を **自動実行しない**
- 必ずユーザー承認を取り、承認された範囲のみ実施
- 「念のため」「とりあえず」での移動 / 削除 / リネームは禁止。明確に安全と確認できるもののみ
- 不確実な場合は提案にとどめ、`docs/manual-tasks/` に書き出して手動対応に回す

### 主要コマンド

- 何から始めればいいか分からない: `/cc-development-team:guide`（迷ったらこれ）
- アプリ案を相談: `/cc-development-team:brainstorm`
- 仕様書を作成 / 更新: `/cc-development-team:architect [name]`
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

## 7. 部署別 CLAUDE.md（5 ファイル）

以下のディレクトリとファイルを作成する。**既に存在するファイルは上書きしない**（ユーザーが書き込んだ内容を尊重する）。
手順 1 で得た `$PROJECT_TYPE` (`Web` or `Mobile`) に応じて、テンプレートを **1 ファイルずつ Read → Write** する。

### 配置先と参照テンプレート（$VARIANT は `web` または `mobile`）

| 部署 | 書き出し先 | 参照テンプレート |
| --- | --- | --- |
| architect (設計) | `docs/dept/architect/CLAUDE.md` | `${CLAUDE_PLUGIN_ROOT}/templates/dept-claude-md/architect-$VARIANT.md` |
| developer (開発) | `dept/developer/CLAUDE.md` | `${CLAUDE_PLUGIN_ROOT}/templates/dept-claude-md/developer-$VARIANT.md` |
| reviewer (レビュー) | `dept/reviewer/CLAUDE.md` | `${CLAUDE_PLUGIN_ROOT}/templates/dept-claude-md/reviewer-$VARIANT.md` |
| tester (テスト) | `dept/tester/CLAUDE.md` | `${CLAUDE_PLUGIN_ROOT}/templates/dept-claude-md/tester-$VARIANT.md` |
| security-reviewer (セキュリティ) | `dept/security-reviewer/CLAUDE.md` | `${CLAUDE_PLUGIN_ROOT}/templates/dept-claude-md/security-reviewer-$VARIANT.md` |

> 設計部署 (`architect`) は **ドキュメント系** として `docs/dept/` 配下、
> 実作業 4 部署は **コードに近い場所** として `dept/` 配下に置く方針です。

### 手順

5 部署それぞれについて、以下を **必要になった瞬間に** 実施する（一括で全テンプレートを先読みしない）:

1. `${CLAUDE_PLUGIN_ROOT}/templates/dept-claude-md/<部署>-$VARIANT.md` を `Read`
2. 書き出し先パスのファイルが存在しないことを確認（存在すれば **その部署はスキップ**、ユーザーの内容を尊重）
3. 親ディレクトリが無ければ作成
4. Read した内容を `Write` でそのまま書き出す

`CLAUDE_PLUGIN_ROOT` が解決できない場合は、プラグインがインストールされているディレクトリ配下の `templates/dept-claude-md/` を直接参照すること。

## 8. 初期化完了アナウンス（短く）

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

すぐ続けて Step 9 のウェルカム説明に進む（情報を分散させない）。

---

## 9. プラグインの使い方ガイド（初期化完了後に表示）

`${CLAUDE_PLUGIN_ROOT}/templates/init-welcome-guide.md` を `Read` し、内容を **そのまま整形して** ユーザーに表示する。表 (`|---|`) は Markdown としてそのまま出すこと。

`CLAUDE_PLUGIN_ROOT` が解決できない場合は、プラグインがインストールされているディレクトリ配下の `templates/init-welcome-guide.md` を直接参照する。

ウェルカム説明を出し終えたら、最後に以下の 1 行で締める:

```
それでは、楽しい開発を!! 何か困ったら /cc-development-team:guide でいつでも相談できます!
```

これでコマンド終了。ユーザーが次のアクションを取れる状態で待機する。
