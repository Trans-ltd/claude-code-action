#!/bin/bash

# --- .env ファイルの読み込み ---
if [ -f .env ]; then
  echo ".env ファイルを読み込んでいます..."
  set -a
  source .env
  set +a
else
  echo "警告: .env ファイルが見つかりません。環境変数がシェルに設定されていることを前提に処理を続行します。"
fi

# --- 設定項目 ---

# GitHubのOrganization名 または ユーザー名
OWNER="Trans-ltd"

# シークレットを設定したいリポジトリのリスト（スペース区切り）
REPOS=("trans_report" "Trans-Source-Raw-Intermediate-Pipeline" "dbt-bigquery-project" "trans-manus")

# --- 環境変数チェック ---
# スクリプトの実行に必要な環境変数が設定されているか確認します。
if [ -z "$CLAUDE_ACCESS_TOKEN" ] || [ -z "$CLAUDE_REFRESH_TOKEN" ] || [ -z "$CLAUDE_EXPIRES_AT" ]; then
  echo "エラー: 必要な環境変数が設定されていません。" >&2
  echo "以下の環境変数を設定してください:" >&2
  echo "  export CLAUDE_ACCESS_TOKEN='your_token'" >&2
  echo "  export CLAUDE_REFRESH_TOKEN='your_token'" >&2
  echo "  export CLAUDE_EXPIRES_AT='your_expiry_date'" >&2
  exit 1
fi

# --- 実行処理 ---

for REPO in "${REPOS[@]}"; do
  echo "--- Setting secrets for ${OWNER}/${REPO} ---"

  gh secret set CLAUDE_ACCESS_TOKEN --repo "${OWNER}/${REPO}" --body "$CLAUDE_ACCESS_TOKEN"
  gh secret set CLAUDE_REFRESH_TOKEN --repo "${OWNER}/${REPO}" --body "$CLAUDE_REFRESH_TOKEN"
  gh secret set CLAUDE_EXPIRES_AT --repo "${OWNER}/${REPO}" --body "$CLAUDE_EXPIRES_AT"

  echo "✅ Done."
  echo ""
done

echo "すべてのリポジトリへのシークレット設定が完了しました。" 