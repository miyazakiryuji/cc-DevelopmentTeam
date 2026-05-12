# Sharedo 基本設計書（全体設計）

<!-- サンプル: architect モード A の A-4 で生成されたファイル -->

**関連ドキュメント:**
- 構想: [docs/vision/vision.md](../vision/vision.md)
- 機能ロードマップ: [docs/vision/roadmap.md](../vision/roadmap.md)
- 機能ごと要件: [docs/requirements/](../requirements/)
- 機能ごと詳細仕様: [docs/specs/](../specs/)
- デザイン素材: [design/](../../design/)

## 0. プロジェクト前提

- **プロジェクト種別:** Web
- **設計思想 (アーキテクチャパターン):** Feature-based + 軽量レイヤ分け
- **アプリコード配置 (ルート):** src/
- **採用フレームワーク:** Next.js 14 (App Router) + TypeScript

## 1. システム構成

### 1.1 全体構成図

```
[ ブラウザ ] ── HTTPS ──> [ Next.js (Vercel) ]
                              │
                              ├─ Server Actions / API Routes
                              │
                              └── [ Supabase ] (Auth + Postgres + Realtime)
```

### 1.2 採用技術スタック

| レイヤ | 採用 |
| --- | --- |
| フロント | Next.js 14 (App Router) + TypeScript + Tailwind CSS |
| 状態管理 | React Server Components + Zustand (クライアントローカル) |
| バックエンド | Next.js Server Actions |
| DB | Supabase Postgres |
| 認証 | Supabase Auth (Google OAuth) |
| リアルタイム | Supabase Realtime (Postgres Changes 購読) |
| ホスティング | Vercel |
| CI | GitHub Actions (typecheck / lint / test) |

## 2. 機能一覧 (F-XXX マスター)

| ID | 機能名 | 粒度 | フェーズ | 個別ドキュメント |
| --- | --- | --- | --- | --- |
| F-001 | login-flow | Medium | MVP | [requirements](../requirements/login-flow.md) / [specs](../specs/login-flow.md) |
| F-002 | list-management | Medium | MVP | (未着手) |
| F-003 | member-invite | Medium | MVP | (未着手) |
| F-004 | task-crud | Small | MVP | (未着手) |
| F-005 | realtime-sync | Large | MVP | (未着手 / 分割検討) |

## 3. 画面一覧 + 画面遷移図 (俯瞰)

### 画面一覧

- **/** (Landing): 未ログイン時のトップ。CTA = ログイン
- **/login**: Google OAuth 開始
- **/lists**: 自分が参加するリスト一覧
- **/lists/[id]**: リスト詳細 + タスク CRUD
- **/lists/[id]/invite**: 招待 URL 発行
- **/invite/[token]**: 招待リンクからの参加フロー
- **/settings**: アカウント設定

### 画面遷移 (俯瞰)

```
/ ──> /login ──> /lists ──┬──> /lists/[id] ──> /lists/[id]/invite
                            │
                            └──> /settings

外部リンク: /invite/[token] ──> (未ログインなら /login へ) ──> /lists/[id]
```

## 4. データモデル (俯瞰)

### ER 図

```
users (id, email, name, avatar_url, created_at)
   │
   │ owns / participates_in
   ▼
lists (id, name, owner_id, created_at)
   │
   │ has many
   ▼
tasks (id, list_id, content, completed, completed_by, completed_at, created_at)

list_members (list_id, user_id, role, joined_at)   ← 多対多
invitations (id, list_id, token, created_by, expires_at)
```

### 主要テーブル

- **users**: Supabase Auth と紐づく (`id` = `auth.users.id`)
- **lists**: リスト本体。`owner_id` で所有者を保持
- **tasks**: リスト内タスク。`completed_by` で誰が完了したか追跡
- **list_members**: メンバーシップ管理 (role = owner / member)
- **invitations**: 招待 URL のトークン。`expires_at` で有効期限管理

## 5. API 一覧 (俯瞰)

Server Actions ベース (`'use server'` で実装):

| 操作 | Server Action |
| --- | --- |
| ログイン開始 | `signInWithGoogle()` |
| ログアウト | `signOut()` |
| リスト一覧取得 | (RSC で直接 fetch) |
| リスト作成 | `createList(name)` |
| リスト削除 | `deleteList(listId)` |
| タスク追加 | `addTask(listId, content)` |
| タスク完了切替 | `toggleTask(taskId)` |
| 招待 URL 発行 | `createInvitation(listId)` |
| 招待 URL から参加 | `joinViaInvitation(token)` |

リアルタイム: Supabase Realtime チャンネルで `lists` / `tasks` テーブルを購読。

## 6. 認証認可 (全体方針)

- **認証方式:** Supabase Auth (Google OAuth 単独、メール/パス無し)
- **セッション:** Supabase が発行する JWT。Cookie に保存 (HttpOnly, Secure, SameSite=Lax)
- **認可ロール:**
  - **owner**: リスト削除・メンバー追加削除・タスク全操作
  - **member**: タスク追加・編集・自分が追加したタスク削除
- **RLS (Row Level Security):** Postgres レベルで全テーブル ON。`list_members` 経由でアクセス可否判定

## 7. 非機能設計 (全体方針)

- **性能:** 初期表示 LCP < 2.5s, リアルタイム反映遅延 < 500ms
- **アクセシビリティ:** WCAG 2.1 AA 準拠 (キーボード操作 / スクリーンリーダー対応)
- **ブラウザ対応:** Chrome / Safari / Edge / Firefox の最新 2 バージョン
- **セキュリティ:** OWASP Top 10、Supabase RLS で認可、CSP / HSTS 必須
- **SEO:** /lists 配下は noindex、ランディングのみ OGP / SEO 対応
- **データ保持:** 削除リストは soft delete 30 日、その後物理削除

## 8. デプロイ・運用

- **デプロイ:** main ブランチ → Vercel 自動デプロイ
- **環境:** dev (ローカル) / preview (PR ごと) / production (main)
- **モニタリング:** Vercel Analytics + Supabase Dashboard
- **エラー追跡:** Sentry (Phase 2 で導入予定、MVP では console + Vercel logs)
- **バックアップ:** Supabase の自動 backup (日次)

---

## ステータス: 確定 (2026-05-10)
