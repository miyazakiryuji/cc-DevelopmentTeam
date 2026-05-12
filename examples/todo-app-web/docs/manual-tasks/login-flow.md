# 手動操作タスク: login-flow

<!-- サンプル: developer が実装中に検出して書き出すファイル -->

このファイルは **人間が UI 操作しないと完了しないタスク** をトラッキングします。
コード側には対応する `// TODO(manual): docs/manual-tasks/login-flow.md#<見出し>` コメントが残されています。

**関連ドキュメント:**
- 仕様書: [docs/specs/login-flow.md](../specs/login-flow.md)

---

## 1. Google Cloud Console で OAuth クライアント ID を発行

**カテゴリ:** 外部サービス設定
**ステータス:** ☐ 未着手

### 手順

1. <https://console.cloud.google.com/> にアクセス
2. プロジェクト作成 (例: `sharedo-prod`)
3. メニュー > 「API とサービス」 > 「OAuth 同意画面」を選択
   - ユーザータイプ: 外部
   - アプリ名: Sharedo
   - サポートメール: 自分のメール
   - スコープ: `userinfo.email`, `userinfo.profile`, `openid`
   - テストユーザー: 自分 (本番公開前は外部ユーザー入れない)
4. 「認証情報」 > 「認証情報を作成」 > 「OAuth クライアント ID」
   - アプリケーションの種類: ウェブアプリケーション
   - 名前: Sharedo Web Client
   - 承認済み JavaScript 生成元: `http://localhost:3000`, `https://<本番ドメイン>`
   - 承認済みリダイレクト URI: `https://<supabase-project>.supabase.co/auth/v1/callback`
5. **クライアント ID とクライアントシークレットを控える**

### 完了の確認方法

- 認証情報画面に作成した OAuth クライアントが表示されている
- クライアント ID とクライアントシークレットがメモされている

### ブロッカー

- Google Cloud アカウントが必要
- 本番ドメインが確定していない場合は development URL のみで一旦進める (後で追加可能)

---

## 2. Supabase プロジェクト作成と Google プロバイダ設定

**カテゴリ:** 外部サービス設定
**ステータス:** ☐ 未着手

### 手順

1. <https://supabase.com/dashboard> にアクセス
2. 「New project」でプロジェクト作成
   - 名前: sharedo
   - DB パスワード: ランダム生成して保存
   - リージョン: Tokyo (asia-northeast1)
3. 左メニュー > Authentication > Providers > Google
4. Enable Google provider を ON
5. Client ID / Client Secret に **手順 1 で取得した値** を貼り付け
6. Save

### 完了の確認方法

- Authentication > Providers で Google が緑色 (Enabled) になっている

### ブロッカー

- 手順 1 が完了していること

---

## 3. 環境変数の設定 (.env.local)

**カテゴリ:** ローカル環境設定
**ステータス:** ☐ 未着手

### 手順

1. プロジェクトルートに `.env.local` を作成 (gitignore 済み)
2. Supabase ダッシュボード > Settings > API から以下を取得し、`.env.local` に書く:
   ```
   NEXT_PUBLIC_SUPABASE_URL=https://<project>.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=<anon-key>
   ```
3. `npm run dev` で起動して、`/` のログインボタンを押す → Google 同意画面が出れば成功

### 完了の確認方法

- ローカルで `/` から Google ログインができる
- ログイン後 `/lists` に着地する

### ブロッカー

- 手順 1, 2 が完了していること

### 関連コード

```
src/lib/supabase/client.ts:5
// TODO(manual): docs/manual-tasks/login-flow.md#3-環境変数の設定-envlocal — NEXT_PUBLIC_SUPABASE_URL が設定されていません
```

---

## 4. 本番デプロイ時の Vercel 環境変数設定

**カテゴリ:** デプロイ
**ステータス:** ☐ 未着手 (本番リリース直前に実施)

### 手順

1. Vercel ダッシュボードでプロジェクトを開く
2. Settings > Environment Variables
3. 以下を Production / Preview に追加:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
4. Re-deploy

### 完了の確認方法

- 本番ドメインで Google ログインが成功する

### ブロッカー

- 手順 1, 2, 3 が完了していること
- 本番ドメインが決まっていること (Google Cloud Console の Authorized redirect URI 追加も必要)

---

## ステータス変更ログ

- 2026-05-10: ファイル作成
