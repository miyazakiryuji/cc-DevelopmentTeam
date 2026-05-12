# Sharedo — 機能ロードマップ

<!-- サンプル: architect モード A の A-3 で生成されたファイル -->

## MVP

これが揃わないと「共有 Todo アプリ」を名乗れない核機能。MVP リリースの目標。

- [x] login-flow (Medium) — Google OAuth でログイン
- [ ] list-management (Medium) — Todo リストの作成・編集・削除
- [ ] member-invite (Medium) — リストへのメンバー招待 (URL 共有)
- [ ] task-crud (Small) — タスクの追加・完了・削除
- [ ] realtime-sync (Large) — リスト・タスクのリアルタイム同期

## Phase 2

MVP リリース後、ユーザーフィードバックを見ながら追加検討。

- task-reminder — 期限付きタスクとリマインダー通知 (controlled push)
- list-templates — よくあるリスト (買い物 / 旅行) のテンプレ
- pwa-installable — PWA としてホーム画面追加可能に
- list-archive — 完了済みリストのアーカイブ

## Future (夢リスト)

「いつかやりたい」レベル。現時点では深く考えない。

- ネイティブモバイルアプリ (iOS / Android)
- リスト間のタスク移動
- カレンダー連携 (Google Calendar)
- 音声入力でタスク追加 (スマートスピーカー)
- 家族の活動レポート (月次)

---

進捗ステータスは `/cc-development-team:status` で集計されます。
