# opencode-server

A self-hosted [OpenCode](https://opencode.ai) server, containerized for deployment via Docker Compose / Portainer. Intended for use as the backend for T3 Code.

## What this is

- `Dockerfile` builds a minimal Debian image with OpenCode installed and running as `opencode serve`.
- A GitHub Actions workflow (`.github/workflows/build.yml`) builds and publishes the image to GitHub Container Registry (`ghcr.io/johanhansson/opencode-server:latest`) on every push to `main`.
- `docker-compose.yml` pulls that published image directly, so Portainer only needs to redeploy the stack rather than build locally.

## Deploying with Portainer

1. Create a new stack in Portainer using this repository's `docker-compose.yml` (either via Git repository deployment, or by pasting its contents).
2. Set the following environment variables on the stack:
   - `ANTHROPIC_API_KEY` — your Anthropic API key.
   - `OPENCODE_SERVER_PASSWORD` — password used to authenticate against the OpenCode server.
3. Deploy the stack.

Session/config data persists across redeploys via the `opencode-data` and `opencode-config` named volumes. Project files placed in the `./workspace` directory on the host are mounted into the container at `/workspace`.

## Usage

Once deployed, the server is reachable at:

```
http://<host>:4096
```

Point T3 Code at this address to use it as its OpenCode backend.

## Updating

Push to `main` — GitHub Actions rebuilds and republishes the image automatically. Redeploy/pull the stack in Portainer to pick up the new image.