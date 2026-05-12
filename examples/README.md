# examples/

このディレクトリには、`/cc-development-team:init-dept` 実行後にどんな成果物が生まれるかを示す **サンプルプロジェクト** が入っています。

> **重要:** このディレクトリは **参考用のサンプル** です。`init-dept` が自動でコピーするわけではありません。「実プロジェクトのドキュメントってどう書けばいいの?」を知りたいときに眺める用です。

## 収録サンプル

| ディレクトリ | プロジェクト種別 | 設計思想 | アプリコード配置 |
| --- | --- | --- | --- |
| [todo-app-web/](./todo-app-web/) | Web | Feature-based (お任せ) | `src/` |

## このサンプルから学べること

- vision / roadmap / basic-design / requirements / specs / manual-tasks の **書き方の粒度**
- 全体設計 (basic-design) と 個別設計 (requirements + specs) の **責任範囲の線引き**
- 受け入れ基準を **Given-When-Then 形式** で書く具体例
- 手動操作タスク (Firebase 設定など) を `docs/manual-tasks/` で追跡する具体例
- F-XXX 機能 ID を通じた各ドキュメント間の **トレーサビリティ**

## 注意

- 実装コード (`src/` 以下) は **含まれていません**。設計ドキュメントの書き方の見本のみ
- サンプルアプリの内容は架空のものです (Todo アプリ)
- このサンプルを base にして新規プロジェクトを始めることもできますが、新しく作るなら `/cc-development-team:init-dept` で初期化する方が手っ取り早いです
