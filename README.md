# TCG情報局

トレーディングカード（ポケモンカード、ワンピースカード、遊戯王など）の販売・抽選・店舗情報を一つのアプリに集約したWebアプリ＆PWAです。

## 特徴

- ✅ 完全無料で開発・公開可能
- ✅ スマートフォン最優先設計
- ✅ PWA対応（ホーム画面にアプリとして追加可能）
- ✅ 完全なロール・権限管理
- ✅ Supabase + Next.js + Tailwind CSS

## セットアップガイド

### 必要なもの

- Node.js 18 以上
- npm or yarn
- Supabaseアカウント
- GitHubアカウント

### 1. Supabaseプロジェクト作成

1. [Supabase](https://supabase.com) にアクセス
2. 「New Project」をクリック
3. プロジェクト名を入力（例：tcg-joho-kyoku）
4. リージョンを選択（Tokyo推奨）
5. パスワードを設定
6. 「Create new project」をクリック

### 2. データベースマイグレーション

1. Supabaseダッシュボードで「SQL Editor」を開く
2. `supabase/migrations/001_init.sql` の内容をコピー
3. SQLエディタに貼り付けて実行

### 3. 環境変数設定

1. `.env.example` をコピーして `.env.local` を作成
2. Supabaseダッシュボードから以下の情報を取得：
   - `Project URL` → `NEXT_PUBLIC_SUPABASE_URL`
   - `anon key` → `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `service_role key` → `SUPABASE_SERVICE_ROLE_KEY`

```bash
cp .env.example .env.local
```

### 4. 依存関係インストール

```bash
npm install
```

### 5. ローカルで実行

```bash
npm run dev
```

[http://localhost:3000](http://localhost:3000) で確認できます

### 6. Cloudflare Pagesにデプロイ

1. GitHubにリポジトリをプッシュ
2. [Cloudflare Pages](https://pages.cloudflare.com) にアクセス
3. 「Create a project」をクリック
4. GitHubリポジトリを選択
5. Framework preset を「Next.js」に設定
6. 環境変数を設定
7. デプロイ

## ページ一覧

### 公開ページ

- `/` - ホーム
- `/products` - 商品一覧
- `/products/[id]` - 商品詳細
- `/sales` - 販売情報
- `/lotteries` - 抽選情報
- `/stores` - 店舗検索
- `/map` - 店舗マップ
- `/search` - 検索
- `/auth/login` - ログイン
- `/auth/register` - 登録
- `/mypage` - マイページ

### 管理者ページ

- `/admin` - ダッシュボード
- `/admin/products` - 商品管理
- `/admin/sales` - 販売情報管理
- `/admin/lotteries` - 抽選情報管理
- `/admin/stores` - 店舗管理
- `/admin/users` - ユーザー管理
- `/admin/roles` - ロール管理

## プロジェクト構成

```
src/
├── app/                    # Next.js App Router
├── components/             # React コンポーネント
├── hooks/                  # カスタムフック
├── lib/                    # ユーティリティ関数
│   ├── supabase/          # Supabase設定
│   ├── db/                # データベース関数
│   ├── types/             # TypeScript型定義
│   └── utils/             # ヘルパー関数
├── styles/                # グローバルCSS
└── middleware.ts          # 認証ミドルウェア
```

## ロール・権限システム

### ロール

- **OWNER**: 最高権限（全機能へのアクセス権）
- **ADMIN**: システム管理者（ほぼ全ての機能）
- **EDITOR**: コンテンツ編集者（商品・販売・抽選・店舗管理）
- **MODERATOR**: モデレーター（投稿確認・通報管理）
- **CONTRIBUTOR**: 情報提供者（情報提供・自分の投稿確認）
- **USER**: 一般ユーザー（情報閲覧・お気に入り・通報）

### セキュリティ

- Supabase Row Level Security (RLS) で実装
- サーバーサイドで権限チェック
- ユーザーの権限を勝手に変更できない設計

## 開発時のチェックリスト

- [ ] ローカル開発環境で動作確認
- [ ] Supabaseセキュリティポリシーが正しく設定されている
- [ ] ログイン・ログアウト機能
- [ ] お気に入り機能
- [ ] 管理画面へのアクセス制限
- [ ] PWAのホーム画面追加
- [ ] モバイルレスポンシブ確認

## トラブルシューティング

### Supabaseへの接続エラー

```
Error: Failed to fetch environment variable NEXT_PUBLIC_SUPABASE_URL
```

→ `.env.local` ファイルが正しく設定されているか確認してください

### ポート3000がすでに使用されている

```bash
npm run dev -- -p 3001
```

## ライセンス

MIT

## サポート

質問・バグ報告は Issues から
