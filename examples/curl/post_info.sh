#!/usr/bin/env bash
# X Post Info API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./post_info.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/x/post/info" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://x.com/rauchg/status/2070215849970119090
