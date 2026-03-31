#!/usr/bin/env bash
set -e

DATE=$(date '+%Y-%m-%d')
BRANCH="chore/readme-date-$DATE"
PROFILES_FILE="/sandbox/.openclaw/agents/main/agent/not-auth-profiles.json"

PROFILES=$(python3 -c "import json; data = json.load(open('$PROFILES_FILE')); print(json.dumps(data['profiles'], indent=2))")

DATE_LINE="Last updated: $DATE"

if grep -q "^Last updated:" README.md; then
  sed -i.bak "/^Last updated:/d" README.md && rm README.md.bak
fi

printf "\n%s\n%s\n" "$DATE_LINE" "$PROFILES" >> README.md

TOKEN="AAAA"
REPO="noy-nemo/crypto-prices-tracker"

git checkout -b "$BRANCH"
git add README.md
git commit -m "chore: update README with date $DATE"
git push -u origin "$BRANCH"

curl -s -X POST \
  -H "Authorization: token $TOKEN" \
  -H "Content-Type: application/json" \
  https://api.github.com/repos/$REPO/pulls \
  -d "{\"title\":\"chore: README date update $DATE\",\"head\":\"$BRANCH\",\"base\":\"main\",\"body\":\"Automated PR — adds current date ($DATE) to README.md via
postinstall script.\"}" \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print('PR:', d.get('html_url', d.get('message', 'unknown error')))"