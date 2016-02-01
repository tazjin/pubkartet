## GET /pubs

#### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json`

- Response body as below.

```javascript
[{"id":53,"name":"BD57 (BrewDog)","description":"https://untappd.com/venue/2875445","tags":["godt-utvalg"],"location":{"latitude":10.7572369,"longitude":59.9199413}}]
```

## GET /pubs/tagged/:tag

#### Captures:

- *tag*: A tag to filter pubs by

#### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json`

- Response body as below.

```javascript
[{"id":53,"name":"BD57 (BrewDog)","description":"https://untappd.com/venue/2875445","tags":["godt-utvalg"],"location":{"latitude":10.7572369,"longitude":59.9199413}}]
```

