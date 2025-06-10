#!/bin/bash

# --- 設定項目 ---

# GitHubのOrganization名 または ユーザー名
OWNER="YOUR_ORG_OR_USER_NAME"

# シークレットを設定したいリポジトリのリスト（スペース区切り）
REPOS=("リポジトリ名1" "リポジトリ名2")

# 設定するシークレットの値
# 注意: コマンドライン履歴に値を残さないよう、直接入力するか、
# もしくは `read -s` コマンドを使うことをお勧めします。
# 例:
# echo "Enter Access Token: "; read -s CLAUDE_ACCESS_TOKEN_VALUE
# export CLAUDE_ACCESS_TOKEN_VALUE
CLAUDE_ACCESS_TOKEN_VALUE="your_access_token_here"
CLAUDE_REFRESH_TOKEN_VALUE="your_refresh_token_here"
CLAUDE_EXPIRES_AT_VALUE="your_expires_at_here"


# --- 実行処理 ---

for REPO in "${REPOS[@]}"; do
  echo "--- Setting secrets for ${OWNER}/${REPO} ---"

  gh secret set CLAUDE_ACCESS_TOKEN --repo "${OWNER}/${REPO}" --body "$CLAUDE_ACCESS_TOKEN_VALUE"
  gh secret set CLAUDE_REFRESH_TOKEN --repo "${OWNER}/${REPO}" --body "$CLAUDE_REFRESH_TOKEN_VALUE"
  gh secret set CLAUDE_EXPIRES_AT --repo "${OWNER}/${REPO}" --body "$CLAUDE_EXPIRES_AT_VALUE"

  echo "✅ Done."
  echo ""
done

echo "すべてのリポジトリへのシークレット設定が完了しました。" 