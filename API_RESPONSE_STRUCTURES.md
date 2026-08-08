# Anime API Response Structures

Based on research from Consumet and similar anime providers, here are the common API response formats used by anime streaming services including Indonesian providers (Oploverz, Animasu, Kusonime, Anoboy).

## Common Response Patterns

### 1. **Search/Anime List Response**

All major anime streaming APIs use similar structures for list responses:

```json
{
  "currentPage": 1,
  "hasNextPage": true,
  "results": [
    {
      "id": "string (unique identifier)",
      "title": "Anime Title",
      "url": "https://example.com/anime/slug",
      "image": "https://example.com/image.jpg",
      "releaseDate": "2023-01-01",
      "subOrDub": "sub",
      "type": "TV"
    }
  ]
}
```

**Key Points:**
- **currentPage**: 1-based page number (some APIs use 0-based)
- **hasNextPage**: Boolean indicating if more results exist
- **results**: Array of anime items
- **Pagination**: Typically controlled via `?page=1` query parameter
- **Fields per item**: `id`, `title`, `url`, `image`, `releaseDate`, `subOrDub`

### 2. **Anime Detail/Info Response**

Detailed information about a single anime:

```json
{
  "id": "string",
  "title": "Anime Title",
  "url": "https://example.com/anime/slug",
  "image": "https://example.com/image.jpg",
  "description": "Long description of the anime",
  "genres": ["Action", "Adventure", "Comedy"],
  "subOrDub": "sub",
  "type": "TV",
  "status": "Ongoing",
  "otherName": "Alternative Title / Japanese Name",
  "totalEpisodes": 24,
  "episodes": [
    {
      "id": "episode-id-1",
      "number": 1,
      "title": "Episode Title",
      "url": "https://example.com/watch/..."
    },
    {
      "id": "episode-id-2",
      "number": 2,
      "title": "Episode Title 2",
      "url": "https://example.com/watch/..."
    }
  ]
}
```

**Key Points:**
- **episodes array**: Paginated in some APIs (`episodePage` parameter)
- **status**: "Ongoing", "Completed", "Not yet aired"
- **totalEpisodes**: Total count (helpful for pagination)
- **type**: "TV", "Movie", "OVA", "ONA", "Special"

### 3. **Episode Streaming Links Response**

Information about where to stream an episode:

```json
{
  "headers": {
    "Referer": "https://example.com"
  },
  "sources": [
    {
      "url": "https://stream.example.com/video.mp4",
      "quality": "1080p",
      "isM3U8": false
    },
    {
      "url": "https://stream.example.com/playlist.m3u8",
      "quality": "auto",
      "isM3U8": true
    }
  ],
  "download": {
    "url": "https://download.example.com/video.mp4",
    "quality": "1080p"
  }
}
```

**Key Points:**
- **headers**: CORS headers needed for streaming
- **sources array**: Multiple streaming quality options
- **isM3U8**: Boolean indicating HLS stream format
- **quality**: Resolution or "auto" for HLS
- **download**: Optional download link

### 4. **Episode Servers Response**

Available servers for an episode:

```json
{
  "id": "episode-id",
  "servers": [
    {
      "name": "Server Name",
      "url": "https://example.com/embed/...",
      "embedId": "embed-id"
    },
    {
      "name": "Backup Server",
      "url": "https://example.com/embed/...",
      "embedId": "embed-id-2"
    }
  ]
}
```

---

## Provider-Specific Details

### **Consumet Providers (HiAnime, AnimeSama, Animepahe)**

#### HiAnime Search
```
GET https://api.consumet.org/anime/hianime/{query}?page=1

Response:
{
  "currentPage": 1,
  "hasNextPage": true,
  "results": [
    {
      "id": "one-piece-100",
      "title": "One Piece",
      "url": "https://hianime.to/watch/...",
      "image": "https://image-cdn.com/...",
      "releaseDate": "1999",
      "subOrDub": "sub"
    }
  ]
}
```

#### AnimeSama Search
```
GET https://api.consumet.org/anime/animesama/{query}

Response:
{
  "currentPage": 1,
  "hasNextPage": false,
  "results": [
    {
      "id": "string",
      "title": "Naruto",
      "url": "https://animesama.to/anime/...",
      "image": "https://image-cdn.com/..."
    }
  ]
}
```

#### Animepahe Search
```
GET https://api.consumet.org/anime/animepahe/{query}

Response:
{
  "currentPage": 0,
  "hasNextPage": true,
  "results": [
    {
      "id": "uuid-format-id",
      "title": "Demon Slayer",
      "image": "https://image-cdn.com/...",
      "releaseDate": "2019",
      "subOrDub": "sub"
    }
  ]
}
```

#### Get Anime Info (Animepahe)
```
GET https://api.consumet.org/anime/animepahe/info/{id}?episodePage=1

Response:
{
  "id": "uuid-format-id",
  "title": "Demon Slayer",
  "url": "https://animepahe.to/anime/...",
  "image": "https://image-cdn.com/...",
  "releaseDate": "2019",
  "description": "Description here",
  "genres": ["Action", "Demons", "Shounen"],
  "subOrDub": "sub",
  "type": "TV",
  "status": "Ongoing",
  "otherName": "Kimetsu no Yaiba",
  "totalEpisodes": 26,
  "episodes": [
    {
      "id": "episode-id-uuid",
      "number": 1,
      "url": "https://animepahe.to/episode/..."
    }
  ]
}
```

#### Get Anime Info (HiAnime)
```
GET https://api.consumet.org/anime/hianime/info?id=one-piece-100

Response:
{
  "id": "one-piece-100",
  "title": "One Piece",
  "url": "https://hianime.to/watch/...",
  "image": "https://image-cdn.com/...",
  "description": "Description",
  "genres": ["Action", "Adventure", "Comedy"],
  "subOrDub": "sub",
  "type": "TV",
  "status": "Ongoing",
  "otherName": "One Piece",
  "totalEpisodes": 1000,
  "episodes": [
    {
      "id": "episode-id-string",
      "number": 1,
      "title": "Romance Dawn",
      "url": "https://hianime.to/watch/..."
    }
  ]
}
```

---

## Indonesian Anime Provider Patterns

Based on reverse engineering from similar providers, Indonesian anime APIs (Oploverz, Animasu, Kusonime, Anoboy) typically follow these patterns:

### Expected Structure for Indonesian Providers

```javascript
// List/Search Response
{
  page: 1,
  per_page: 25,
  total_pages: 10,
  total_results: 250,
  data: [
    {
      id: "anime_id",
      title: "Anime Title",
      slug: "anime-title",
      image: "https://cdn.example.com/poster.jpg",
      status: "ongoing",  // or "completed", "upcoming"
      episodes_count: 24,
      genres: ["Action", "Adventure"],
      rating: 8.5
    }
  ]
}

// Anime Detail Response
{
  id: "anime_id",
  title: "Anime Title",
  slug: "anime-title",
  image: "https://cdn.example.com/poster.jpg",
  cover: "https://cdn.example.com/cover.jpg",
  description: "Long description",
  status: "ongoing",
  episodes_count: 24,
  genres: ["Action", "Adventure"],
  rating: 8.5,
  year: 2023,
  studio: "Studio Name",
  episodes: [
    {
      id: "ep_1",
      number: 1,
      title: "Episode 1",
      aired_date: "2023-01-01",
      servers: [
        {
          name: "Server1",
          embed_url: "https://embed.example.com/..."
        }
      ]
    }
  ]
}

// Episode Streaming Response
{
  episode_id: "ep_1",
  episode_number: 1,
  streams: [
    {
      server: "Server1",
      type: "iframe",
      url: "https://embed.example.com/...",
      quality: "HD"
    }
  ],
  download_links: [
    {
      quality: "1080p",
      url: "https://download.example.com/..."
    }
  ]
}
```

---

## Key Differences Between Providers

| Provider | Page Type | ID Format | Pagination | Notable Fields |
|----------|-----------|-----------|-----------|-----------------|
| HiAnime | 1-based | String (slug) | `?page=1` | `currentPage`, `hasNextPage` |
| AnimeSama | 1-based | String | Implicit | `currentPage`, `hasNextPage` |
| Animepahe | 0-based | UUID | `?episodePage=1` | Uses UUID format IDs |
| Indonesian APIs | Varies | Various | `?page=1` or custom | May include `rating`, `studio`, `year` |

---

## Common Query Parameters

### Pagination
```
?page=1
?page_num=1
?offset=0&limit=25
?episodePage=1  (Animepahe)
```

### Search/Filtering
```
?q=search+query
?search=anime+name
?genre=action
?status=ongoing
?sort=latest
```

### Episodes
```
?episodePage=1  (Animepahe)
?episode=1
?ep=1
```

---

## Error Responses

### Standard Error Format
```json
{
  "error": "Not Found",
  "message": "Anime not found",
  "status": 404
}
```

### Rate Limit
```json
{
  "error": "Too Many Requests",
  "message": "Rate limit exceeded",
  "status": 429,
  "retry_after": 60
}
```

---

## Implementation Notes

1. **Always check `hasNextPage`** before making next page requests
2. **Handle both null and missing fields** gracefully
3. **Set appropriate User-Agent headers** to avoid blocking
4. **Cache responses** with appropriate TTLs (typically 24-48 hours)
5. **Use episode pagination** for large anime (1000+ episodes)
6. **Implement error retry logic** for rate-limited responses
7. **Parse date formats** carefully - they vary by provider (ISO, DD/MM/YYYY, etc.)

---

## Field Normalization Example

```dart
// Normalize different provider formats to common structure
class NormalizedAnimeList {
  int? currentPage;
  bool? hasNextPage;
  List<NormalizedAnimeItem> results = [];

  // From different provider formats
  factory NormalizedAnimeList.fromHiAnime(Map<String, dynamic> json) {
    return NormalizedAnimeList()
      ..currentPage = json['currentPage']
      ..hasNextPage = json['hasNextPage']
      ..results = (json['results'] as List)
          .map((item) => NormalizedAnimeItem.fromJson(item))
          .toList();
  }

  factory NormalizedAnimeList.fromIndonesianAPI(Map<String, dynamic> json) {
    return NormalizedAnimeList()
      ..currentPage = json['page'] ?? 1
      ..hasNextPage = (json['page'] ?? 1) < (json['total_pages'] ?? 1)
      ..results = (json['data'] as List)
          .map((item) => NormalizedAnimeItem.fromJson(item))
          .toList();
  }
}
```

