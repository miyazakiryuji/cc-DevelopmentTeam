# 詳細仕様書: login-flow

<!-- サンプル: architect モード B の B-4 (章ごと対話) で生成されたファイル -->

**機能 ID:** F-001
**フェーズ:** MVP
**粒度:** Medium

**関連ドキュメント:**
- 全体設計: [docs/basic-design/basic-design.md](../basic-design/basic-design.md)
- 要件定義書: [docs/requirements/login-flow.md](../requirements/login-flow.md)
- 手動操作タスク: [docs/manual-tasks/login-flow.md](../manual-tasks/login-flow.md)
- 関連デザイン素材: [design/mockups/login/](../../design/mockups/login/) (本サンプルでは省略)

## 1. 概要

Supabase Auth の Google OAuth プロバイダを使い、Next.js Server Actions 経由でログイン / ログアウトを実装する。
セッションは Supabase が発行する JWT を Cookie で管理。未ログインで `/lists/*` 配下にアクセスした場合は middleware で `/login` にリダイレクトする。

## 2. 画面構成

### 2.1 / (Landing)

- 中央に「Sharedo」ロゴ + キャッチコピー
- メイン CTA: `<button>Google でログイン</button>` (Google ロゴ付き)
- フッタ: プライバシーポリシー / 利用規約リンク (Phase 2 で実装、MVP では `#` プレースホルダ)

### 2.2 /login

- 内部処理用エンドポイント。直接アクセスされた場合は Landing と同じ CTA を表示
- Server Action `signInWithGoogle()` を呼び出し、Supabase の OAuth URL にリダイレクト

### 2.3 OAuth コールバック (`/auth/callback`)

- Supabase からの callback を受け取る Route Handler
- code を session に交換し、`/lists` にリダイレクト
- 招待 URL 経由の場合は `?next=/invite/<token>` を伝搬

## 3. データモデル (この機能で触れるもの)

### 3.1 既存テーブル (basic-design 参照)

- `auth.users` (Supabase 標準)
- `public.users` (アプリ独自プロファイル)

### 3.2 公開ユーザープロファイル (`public.users`)

```sql
CREATE TABLE public.users (
  id        UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email     TEXT NOT NULL,
  name      TEXT,
  avatar_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

初回ログイン時に Supabase の `auth.users` から `id` / `email` / `raw_user_meta_data.name` / `raw_user_meta_data.avatar_url` を抽出して INSERT (upsert)。

### 3.3 RLS ポリシー

```sql
-- public.users は本人のみ SELECT / UPDATE
CREATE POLICY users_self_select ON public.users
  FOR SELECT USING (auth.uid() = id);
CREATE POLICY users_self_update ON public.users
  FOR UPDATE USING (auth.uid() = id);
```

## 4. API シグネチャ (Server Actions)

### 4.1 `signInWithGoogle(returnTo?: string): Promise<{ url: string }>`

- 引数:
  - `returnTo` (optional): ログイン後の遷移先パス。デフォルトは `/lists`
- 戻り値: `{ url }` (OAuth プロバイダの URL)。クライアントはこの URL に遷移する
- エラー: ネットワーク失敗時は `{ error: "認証サービスに接続できませんでした" }`

### 4.2 `signOut(): Promise<void>`

- セッションを破棄し、`/` にリダイレクト
- Cookie もクリアする

### 4.3 `getCurrentUser(): Promise<User | null>` (RSC 内で使う helper)

- 戻り値: ログイン済みなら `{ id, email, name, avatar_url }`、未ログインなら `null`

## 5. middleware による認可ガード

`middleware.ts` で以下のパスを保護:
- `/lists/**` → 未ログインなら `/login` にリダイレクト (`?next=<原パス>` 付き)
- `/settings` → 同上
- `/` `/login` `/invite/*` → ガード対象外

## 6. 受け入れ基準 (Given-When-Then)

### 6.1 ハッピーパス

**AC-1: 新規ユーザーが Google ログインしてリスト一覧に着地する**
- **Given:** 未ログインのユーザーが `/` にアクセス
- **When:** 「Google でログイン」ボタンを押下し、Google で同意する
- **Then:**
  - `/lists` に遷移している
  - `public.users` に新規レコードが作成されている
  - 画面に「最初のリストを作りましょう」CTA が表示されている

**AC-2: 既存ユーザーがブラウザを開き直しても自動ログインしている**
- **Given:** 以前ログインしてセッション Cookie が残っているユーザー
- **When:** `/` にアクセスする
- **Then:** `/lists` に自動リダイレクトされる

**AC-3: 招待 URL 経由の新規ユーザーが、ログイン後に招待リストに着地する**
- **Given:** 未ログインユーザーが招待 URL (`/invite/<token>`) を開く
- **When:** Google ログインを完了する
- **Then:** 招待されたリスト `/lists/<id>` に着地し、`list_members` にレコードが追加されている

### 6.2 エラー系

**AC-4: Google OAuth でキャンセルしたら戻ってこられる**
- **Given:** Landing で「Google でログイン」を押下した直後
- **When:** Google の同意画面で「キャンセル」を押す
- **Then:**
  - `/` に戻っている
  - 「ログインがキャンセルされました」のトースト表示

**AC-5: セッション期限切れ後の保護ページアクセスはログインに飛ぶ**
- **Given:** セッション JWT が期限切れの状態
- **When:** `/lists/abc` にアクセスする
- **Then:**
  - `/login?next=/lists/abc` にリダイレクトされる
  - 再ログイン後に元の `/lists/abc` に着地する

### 6.3 境界値・特殊系

**AC-6: 同じユーザーが 2 回ログインしても重複レコードが作られない**
- **Given:** `public.users` に既存レコードがあるユーザー
- **When:** 一度ログアウトし、再度 Google ログインする
- **Then:** `public.users` レコードは 1 件のまま (upsert で更新される)、`email` や `name` が Google 側で変わっていれば最新値に更新される

**AC-7: 認可ガード対象外のページは未ログインで開ける**
- **Given:** 未ログイン状態
- **When:** `/` または `/invite/<token>` にアクセスする
- **Then:** リダイレクトされず、ページが表示される

## 7. 実装の注意点

- Supabase クライアントは **Server Component 用 / Client Component 用 / Route Handler 用** で別インスタンス。`@supabase/ssr` パッケージのヘルパーを使う
- token を `localStorage` に保存しない (XSS リスク)。Cookie 一択
- 初回ユーザー作成の upsert は `auth.users` への INSERT トリガーで自動化も可能だが、MVP では Server Action 側で明示的に行う方が制御しやすい

## 8. 手動操作タスク

詳細: [docs/manual-tasks/login-flow.md](../manual-tasks/login-flow.md)

- Google Cloud Console で OAuth クライアント ID を発行
- Supabase ダッシュボードで Google プロバイダ設定
- 環境変数 (`.env.local`) に Supabase URL / anon key を設定
- 本番ドメインの authorized redirect URI 登録

---

## ステータス: 確定 (2026-05-10)
