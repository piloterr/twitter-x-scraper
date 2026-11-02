#!/usr/bin/env bash
# X Profile Info API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./profile_info.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/x/profile/info" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=elonmusk
