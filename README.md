<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Weibo Scraper API by Piloterr – scrape Weibo data as JSON" width="100%"></a>
</p>

# Weibo Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Weibo Scraper API** lets you extract public data from Weibo as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Weibo Post Info API** — Retrieve one public Weibo post by post id, including text, images, publish time, engagement counts, and author profile.
- **Weibo Search API** — Search public Weibo posts by keywords.

Use it for brand monitoring, social listening, influencer research, ad intelligence or content analytics on public data.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Weibo Post Info API](#weibo-post-info-api) | `/v2/weibo/post/info` | 2 | Retrieve one public Weibo post by post id, including text, images, publish time, engagement counts, and author profile. |
| [Weibo Search API](#weibo-search-api) | `/v2/weibo/search` | 2 | Search public Weibo posts by keywords. Each post includes the author, text, publish time, engagement counts, image, and video link. |

## Table of contents

- [How it works](#how-it-works)
- [Weibo Post Info API](#weibo-post-info-api)
- [Weibo Search API](#weibo-search-api)
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

## Weibo Post Info API

Retrieve one public Weibo post by post id, including text, images, publish time, engagement counts, and author profile.

`GET | POST https://api.piloterr.com/v2/weibo/post/info` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Weibo post id. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/weibo/post/info",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "5062595839264600",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type WeiboPostInfo = {
  post?: {
    id?: string;
    url?: string;
    pics?: {
      pid?: string;
      url?: string;
      large?: Record<string, unknown>;
    }[];
    text?: string;
    user?: {
      id?: number;
      verified?: boolean;
      avatar_url?: string;
      screen_name?: string;
      followers_count?: string;
    };
    source?: string;
    video_url?: unknown;
    created_at?: string;
    reposts_count?: number;
    comments_count?: number;
    attitudes_count?: number;
  };
};

const params = new URLSearchParams({
  "query": "5062595839264600",
});

const response = await fetch(`https://api.piloterr.com/v2/weibo/post/info?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as WeiboPostInfo;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/weibo/post/info
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "5062595839264600"}
```
</details>

### Output example

Response shape with placeholder values — field names follow the API reference.

```json
{
  "post": {
    "id": "example",
    "url": "example",
    "pics": [
      {}
    ],
    "text": "example",
    "user": {
      "id": 0,
      "verified": false,
      "avatar_url": "example",
      "screen_name": "example",
      "followers_count": "example"
    },
    "source": "example",
    "video_url": "example",
    "created_at": "example",
    "reposts_count": 0,
    "comments_count": 0,
    "attitudes_count": 0
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `post` | object |  |
| `post.id` | string |  |
| `post.url` | string |  |
| `post.pics[]` | object[] |  |
| `post.text` | string |  |
| `post.user` | object |  |
| `post.source` | string |  |
| `post.video_url` | object |  |
| `post.created_at` | string |  |
| `post.reposts_count` | integer |  |
| `post.comments_count` | integer |  |
| `post.attitudes_count` | integer |  |

## Weibo Search API

Search public Weibo posts by keywords. Each post includes the author, text, publish time, engagement counts, image, and video link.

`GET | POST https://api.piloterr.com/v2/weibo/search` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Keywords to search, such as AI. |
| `page` | number | — | Page number, starting at 1. Default 1. Page 2 is the next slice of the same keywords. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/weibo/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "AI",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type WeiboSearch = {
  results?: {
    id?: string;
    url?: string;
    text?: string;
    source?: string;
    user_id?: number;
    image_url?: string;
    user_name?: string;
    video_url?: string;
    avatar_url?: string;
    created_at?: string;
    reposts_count?: number;
    comments_count?: number;
    attitudes_count?: number;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "AI",
});

const response = await fetch(`https://api.piloterr.com/v2/weibo/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as WeiboSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/weibo/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "AI"}
```
</details>

### Output example

Response shape with placeholder values — field names follow the API reference.

```json
{
  "results": [
    {
      "id": "example",
      "url": "example",
      "text": "example",
      "source": "example",
      "user_id": 0,
      "image_url": "example",
      "user_name": "example",
      "video_url": "example",
      "avatar_url": "example",
      "created_at": "example",
      "reposts_count": 0,
      "comments_count": 0,
      "attitudes_count": 0
    }
  ],
  "pagination": {
    "next": "example",
    "page": 0,
    "per_page": 0,
    "total_pages": 0,
    "total_results": 0
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | string |  |
| `results[].url` | string |  |
| `results[].text` | string |  |
| `results[].source` | string |  |
| `results[].user_id` | integer |  |
| `results[].image_url` | string |  |
| `results[].user_name` | string |  |
| `results[].video_url` | string |  |
| `results[].avatar_url` | string |  |
| `results[].created_at` | string |  |
| `results[].reposts_count` | integer |  |
| `results[].comments_count` | integer |  |
| `results[].attitudes_count` | integer |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Post Info | Search |
|---|---|---|
| cURL (Bash) | [`post-info`](examples/curl/post_info.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`post-info`](examples/php/post_info.php) | [`search`](examples/php/search.php) |
| C# | [`post-info`](examples/csharp/PostInfo.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`post-info`](examples/go/post_info.go) | [`search`](examples/go/search.go) |
| Java | [`post-info`](examples/java/PostInfoExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`post-info`](examples/ruby/post_info.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`post-info`](examples/nodejs/post_info.mjs) | [`search`](examples/nodejs/search.mjs) |

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
- **One API key, hundreds of sources** — Weibo plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Weibo?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/weibo/post/info` **2**, `/v2/weibo/search` **2**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Weibo API return?

Each endpoint returns structured JSON: **Weibo Post Info** — `post`, `post.id`, `post.url`, `post.pics[]`, `post.text`, `post.user`; **Weibo Search** — `results[]`, `results[].id`, `results[].url`, `results[].text`, `results[].source`, `results[].user_id`.

### How do I paginate Weibo results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [Instagram Scraper API](https://github.com/piloterr/instagram-scraper)
- [Kick Scraper API](https://github.com/piloterr/kick-scraper)
- [Patreon Scraper API](https://github.com/piloterr/patreon-scraper)
- [Pinterest Scraper API](https://github.com/piloterr/pinterest-scraper)
- [TikTok Top Ads Scraper API](https://github.com/piloterr/tiktoktopads-scraper)
- [X (Twitter) Scraper API](https://github.com/piloterr/twitter-x-scraper)
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

<sub>Weibo is a trademark of its respective owner. This repository is not affiliated with or endorsed by Weibo. Examples are released under the MIT license.</sub>
