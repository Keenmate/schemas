# KeenMate Schemas

JSON Schemas for KeenMate tooling, served as static files by Caddy.

## Layout

```
schemas/<schema-name>/v<major>.schema.json
```

Served at `https://schemas.keenmate.dev/<schema-name>/v<major>.schema.json`.

| Schema | Latest |
|---|---|
| component-variables | [v1](schemas/component-variables/v1.schema.json) |

## Versioning rules

- **Non-breaking changes** (new optional properties, looser constraints, better descriptions) — edit the current `vN` file in place.
- **Breaking changes** (new required fields, removed/renamed properties, stricter patterns) — copy to `v(N+1).schema.json`, update its `$id`, and leave `vN` untouched.
- `$id` must always match the served URL of the file.
- `latest.schema.json` redirects exist for browsing only; never reference them from `$schema` or `$id`.

## Running

```sh
make image-build   # build registry.km8.es/schemas:prod
make image-run     # serve on http://localhost:12000
make image-stop
make image-clean   # remove container + image
```

Defaults to `podman`. Override `DOCKER_RUNNER`, `IMAGE_NAME`, `CONTAINER_NAME`
or `IMAGE_PORT` in a git-ignored `.makefile.env`, e.g. `DOCKER_RUNNER = docker`.

Try it: http://localhost:12000/component-variables/v1.schema.json
