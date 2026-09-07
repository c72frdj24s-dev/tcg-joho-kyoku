# TCG情報局 - 詳細セットアップガイド

## 初回セットアップ手順（初心者向け）

### ステップ1: 前提条件の確認

以下をインストールしてください：

1. **Node.js** (LTS版を推奨)
   - https://nodejs.org/ からダウンロード
   - インストール後、ターミナルで `node --version` と `npm --version` を確認

2. **Git**
   - https://git-scm.com/download からダウンロード
   - インストール後、ターミナルで `git --version` を確認

3. **テキストエディタ**
   - VS Code推奨: https://code.visualstudio.com/

### ステップ2: GitHub リポジトリをクローン

```bash
git clone https://github.com/c72frdj24s-dev/tcg-joho-kyoku.git
cd tcg-joho-kyoku
```

### ステップ3: Supabase プロジェクト作成

1. https://supabase.com にアクセス
2. 右上の「Sign Up」をクリック
3. メールアドレスとパスワードで登録
4. メール認証を完了
5. ダッシュボードで「Create a new project」をクリック
6. 以下を入力：
   - Organization: 新規作成（任意の名前）
   - Project name: `tcg-joho-kyoku`
   - Database Password: 安全なパスワード（メモしておく）
   - Region: `Tokyo (ap-northeast-1)` を選択
7. 「Create new project」をクリック（初期化完了までしばらく待機）

### ステップ4: データベースセットアップ

1. Supabaseダッシュボード左メニューで「SQL Editor」をクリック
2. 「New query」をクリック
3. `supabase/migrations/001_init.sql` の全内容をコピー
4. SQLエディタに貼り付け
5. 右上の「Run」ボタンをクリック
6. 完了まで待機（エラーが出ないこと確認）

### ステップ5: Supabase認証情報取得

1. Supabaseダッシュボード左メニューで「Project Settings」をクリック
2. 「API」タブをクリック
3. 以下をコピー：
   - **Project URL**: `https://xxxxxxxxxxxx.supabase.co`
   - **anon public key**: `eyJhbGci...`
   - **service_role key**: `eyJhbGci...` (一番下までスクロール)

### ステップ6: 環境変数設定

1. プロジェクトフォルダで `.env.example` をコピー
   ```bash
   cp .env.example .env.local
   ```

2. VS Codeで `.env.local` を開く

3. 以下を編集（ステップ5でコピーした値を使用）：
   ```
   NEXT_PUBLIC_SUPABASE_URL=https://xxxxxxxxxxxx.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGci...
   SUPABASE_SERVICE_ROLE_KEY=eyJhbGci...
   NEXT_PUBLIC_APP_URL=http://localhost:3000
   ```

4. ファ���ルを保存

### ステップ7: 依存関係インストール

```bash
npm install
```

完了まで待機（初回は数分かかる場合あり）

### ステップ8: 開発サーバー起動

```bash
npm run dev
```

起動後、以下が表示されます：
```
> tcg-joho-kyoku@0.1.0 dev
> next dev

▲ Next.js 15.0.0
- Local:        http://localhost:3000
```

### ステップ9: ブラウザで確認

1. ブラウザを開く
2. `http://localhost:3000` にアクセス
3. 「TCG情報局」のホームページが表示されることを確認

## ローカル開発環境での使用

### サーバー停止

ターミナルで `Ctrl + C` を押す

### サーバー再起動

```bash
npm run dev
```

### コード変更時の確認

保存すると自動的にリロードされます

## Cloudflare Pages へのデプロイ

### ステップ1: GitHub にプッシュ

```bash
git add .
git commit -m "Initial commit"
git push origin main
```

### ステップ2: Cloudflare Pages に接続

1. https://pages.cloudflare.com にアクセス
2. 「Create a project」をクリック
3. 「Connect to Git」を選択
4. GitHubでログイン
5. リポジトリ検索で「tcg-joho-kyoku」を選択
6. 「Begin setup」をクリック

### ステップ3: ビルド設定

以下を設定：

- **Framework preset**: `Next.js`
- **Build command**: `npm run build`
- **Build output directory**: `.next`

### ステップ4: 環境変数設定

「Environment variables」セクションで以下を追加：

| キー | 値 |
|-----|----|
| NEXT_PUBLIC_SUPABASE_URL | https://xxxxxxxxxxxx.supabase.co |
| NEXT_PUBLIC_SUPABASE_ANON_KEY | eyJhbGci... |
| SUPABASE_SERVICE_ROLE_KEY | eyJhbGci... |

### ステップ5: デプロイ

「Save and Deploy」をクリック

デプロイ完了後、 Cloudflare が提供する URL でアクセス可能になります

## よくある質問

### Q: ポート3000が既に使用されている

A: 別のポートを使用してください
```bash
npm run dev -- -p 3001
```

### Q: Supabase接続エラーが出る

A: `.env.local` の認証情報が正しいか確認してください

### Q: npm installが失敗した

A: 以下を試してください
```bash
rm -rf node_modules package-lock.json
npm install
```

### Q: ブラウザでリロードしても変更が反映されない

A: `npm run dev` を再起動してください

## 次のステップ

- Phase 2: 認証機能の実装
- Phase 3: 商品・お気に入り機能
- Phase 4: 店舗・販売・抽選機能
- Phase 5: 検索・通知・情報提供
- Phase 6: 管理画面
