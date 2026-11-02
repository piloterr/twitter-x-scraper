<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="X (Twitter) Scraper API by Piloterr – scrape X (Twitter) data as JSON" width="100%"></a>
</p>

# X (Twitter) Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr X (Twitter) Scraper API** lets you extract public data from X (Twitter) as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **X Post Info API** — X Post Info API: fetch public tweet data (text, likes, retweets, views, media) from a status URL or tweet ID via browser rendering.
- **X Profile Info API** — X Profile Info API: fetch public X/Twitter profile data (bio, followers, verification, avatars) from a username or URL via browser rendering.

Use it for brand monitoring, social listening, influencer research, ad intelligence or content analytics on public data.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [X Post Info API](#x-post-info-api) | `/v2/x/post/info` | 2 | X Post Info API |
| [X Profile Info API](#x-profile-info-api) | `/v2/x/profile/info` | 2 | X Profile Info API |

## Table of contents

- [How it works](#how-it-works)
- [X Post Info API](#x-post-info-api)
- [X Profile Info API](#x-profile-info-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## X Post Info API

X Post Info API: fetch public tweet data (text, likes, retweets, views, media) from a status URL or tweet ID via browser rendering.

`GET | POST https://api.piloterr.com/v2/x/post/info` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | X tweet to retrieve. Accepts a full status URL or numeric tweet ID. |
| `return_page_source` | boolean | — | When `true`, return the raw HTML page source as `{"result": "..."}` instead of structured JSON. Defaults to `false`. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/x/post/info",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://x.com/example-user/status/0000000000000000001",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type XPostInfo = {
  url?: string;
  name?: unknown;
  text?: string;
  media?: string[];
  tweet_id?: string;
  username?: string;
  verified?: boolean;
  created_at?: unknown;
  like_count?: number;
  view_count?: number;
  reply_count?: number;
  retweet_count?: number;
};

const params = new URLSearchParams({
  "query": "https://x.com/example-user/status/0000000000000000001",
});

const response = await fetch(`https://api.piloterr.com/v2/x/post/info?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as XPostInfo;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/x/post/info
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://x.com/example-user/status/0000000000000000001"}
```
</details>

### Output example

Response shape with placeholder values — field names follow the API reference.

```json
{
  "url": "example",
  "name": "example",
  "text": "example",
  "media": [
    "example"
  ],
  "tweet_id": "example",
  "username": "example",
  "verified": false,
  "created_at": "example",
  "like_count": 0,
  "view_count": 0,
  "reply_count": 0,
  "retweet_count": 0
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `url` | string |  |
| `name` | object |  |
| `text` | string |  |
| `media` | string[] |  |
| `tweet_id` | string |  |
| `username` | string |  |
| `verified` | boolean |  |
| `created_at` | object |  |
| `like_count` | integer |  |
| `view_count` | integer |  |
| `reply_count` | integer |  |
| `retweet_count` | integer |  |

## X Profile Info API

X Profile Info API: fetch public X/Twitter profile data (bio, followers, verification, avatars) from a username or URL via browser rendering.

`GET | POST https://api.piloterr.com/v2/x/profile/info` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | X profile to look up. Accepts a username, @handle, or profile URL. |
| `return_page_source` | boolean | — | When `true`, return the raw HTML page source as `{"result": "..."}` instead of structured JSON. Defaults to `false`. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/x/profile/info",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "elonmusk",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type XProfileInfo = {
  url?: string;
  name?: string;
  user_id?: string;
  location?: unknown;
  username?: string;
  verified?: boolean;
  created_at?: string;
  description?: string;
  tweet_count?: number;
  followers_count?: number;
  following_count?: number;
  profile_image_url?: string;
  profile_banner_url?: string;
  profile_image_url_normal?: string;
};

const params = new URLSearchParams({
  "query": "elonmusk",
});

const response = await fetch(`https://api.piloterr.com/v2/x/profile/info?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as XProfileInfo;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/x/profile/info
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "elonmusk"}
```
</details>

### Output example

Response shape with placeholder values — field names follow the API reference.

```json
{
  "url": "example",
  "name": "example",
  "user_id": "example",
  "location": "example",
  "username": "example",
  "verified": false,
  "created_at": "example",
  "description": "example",
  "tweet_count": 0,
  "followers_count": 0,
  "following_count": 0,
  "profile_image_url": "example",
  "profile_banner_url": "example",
  "profile_image_url_normal": "example"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `url` | string |  |
| `name` | string |  |
| `user_id` | string |  |
| `location` | object |  |
| `username` | string |  |
| `verified` | boolean |  |
| `created_at` | string |  |
| `description` | string |  |
| `tweet_count` | integer |  |
| `followers_count` | integer |  |
| `following_count` | integer |  |
| `profile_image_url` | string |  |
| `profile_banner_url` | string |  |
| `profile_image_url_normal` | string |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | X Post Info | X Profile Info |
|---|---|---|
| cURL (Bash) | [`post-info`](examples/curl/post_info.sh) | [`profile-info`](examples/curl/profile_info.sh) |
| PHP | [`post-info`](examples/php/post_info.php) | [`profile-info`](examples/php/profile_info.php) |
| C# | [`post-info`](examples/csharp/PostInfo.cs) | [`profile-info`](examples/csharp/ProfileInfo.cs) |
| Go | [`post-info`](examples/go/post_info.go) | [`profile-info`](examples/go/profile_info.go) |
| Java | [`post-info`](examples/java/PostInfoExample.java) | [`profile-info`](examples/java/ProfileInfoExample.java) |
| Ruby | [`post-info`](examples/ruby/post_info.rb) | [`profile-info`](examples/ruby/profile_info.rb) |
| Node.js | [`post-info`](examples/nodejs/post_info.mjs) | [`profile-info`](examples/nodejs/profile_info.mjs) |

## Practical use cases

- **Brand monitoring** — Follow public mentions and engagement around your brand.
- **Social listening** — Analyse public conversations and trends.
- **Influencer research** — Qualify public creator profiles and audience metrics.
- **Ad intelligence** — Study competitors' public ads and creatives.
- **Content analytics** — Benchmark formats and engagement over time.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — X (Twitter) plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape X (Twitter)?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/x/post/info` **2**, `/v2/x/profile/info` **2**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the X (Twitter) API return?

Each endpoint returns structured JSON: **X Post Info** — `url`, `name`, `text`, `media`, `tweet_id`, `username`; **X Profile Info** — `url`, `name`, `user_id`, `location`, `username`, `verified`.

### Can I get the raw HTML instead of JSON?

Yes. Set `return_page_source=true` and the response becomes `{"result": "..."}` with the page source.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [Instagram Scraper API](https://github.com/piloterr/instagram-scraper)
- [Kick Scraper API](https://github.com/piloterr/kick-scraper)
- [Patreon Scraper API](https://github.com/piloterr/patreon-scraper)
- [Pinterest Scraper API](https://github.com/piloterr/pinterest-scraper)
- [TikTok Top Ads Scraper API](https://github.com/piloterr/tiktoktopads-scraper)
- [Weibo Scraper API](https://github.com/piloterr/weibo-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>X (Twitter) is a trademark of its respective owner. This repository is not affiliated with or endorsed by X (Twitter). Examples are released under the MIT license.</sub>
