#!/bin/bash
# Submits all sitemap URLs to IndexNow (Bing, Yandex, Seznam, Naver).
# Bing's index feeds ChatGPT and Copilot citations, so run this after every deploy.
# Usage: ./scripts/indexnow-ping.sh

set -e

KEY="747ae48dd993a58b2b8c4e899f7d5039"
HOST="glp1forwellness.com"

# Extract URLs from the live sitemap
URLS=$(curl -s "https://${HOST}/sitemap.xml" | grep -o '<loc>[^<]*</loc>' | sed 's/<[^>]*>//g')

if [ -z "$URLS" ]; then
  echo "No URLs found in sitemap — is the site live?"
  exit 1
fi

URL_LIST=$(echo "$URLS" | awk '{printf "\"%s\",", $0}' | sed 's/,$//')

echo "Submitting $(echo "$URLS" | wc -l | tr -d ' ') URLs to IndexNow..."

curl -s -X POST "https://api.indexnow.org/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "{
    \"host\": \"${HOST}\",
    \"key\": \"${KEY}\",
    \"keyLocation\": \"https://${HOST}/${KEY}.txt\",
    \"urlList\": [${URL_LIST}]
  }" -w "\nHTTP status: %{http_code}\n"

echo "Done. 200/202 = accepted."
