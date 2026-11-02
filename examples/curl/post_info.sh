#!/usr/bin/env bash
# Weibo Post Info API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./post_info.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/weibo/post/info" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=5062595839264600
