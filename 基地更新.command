#!/bin/bash
cd "$(dirname "$0")"

echo "=========================================="
echo " 🚀 SANCTUARY 全自動同期システム"
echo "=========================================="

# リモートリポジトリが未設定の場合は入力を求める
if ! git remote get-url origin >/dev/null 2>&1; then
    echo "【初回設定】GitHubのURLを登録します。"
    echo "あなたのGitHubの「portal」リポジトリのURLを入力してください:"
    echo "（例: https://github.com/ユーザー名/portal.git）"
    read -r repo_url
    git remote add origin "$repo_url"
    git branch -M main
fi

echo "📦 ファイルの変更を検出中..."
git add .

if git diff --cached --quiet; then
    echo "✨ 変更点はありません。すでに最新状態です。"
else
    git commit -m "Update portal: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "📡 GitHubへ送信中..."
    git push -u origin main
    echo ""
    echo "=========================================="
    echo " ✅ 同期完了！"
    echo " 約1分後にスマホ・PC両方に反映されます。"
    echo "=========================================="
fi

echo ""
read -n 1 -s -r -p "何かキーを押すと画面を閉じます..."
