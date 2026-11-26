# EMQX Docker

[EMQX](https://github.com/emqx/emqx) 5.8.9, the last release under Apache-2.0 (5.9 and later are under the BSL), with the Debian security updates that the upstream image no longer gets. Nothing else changes: same user (`emqx`), entrypoint, ports and configuration as `emqx/emqx:5.8.9`, so it is a drop-in replacement.

## Tags

`ghcr.io/freifunkmuc/emqx-docker`

| Tag | Meaning |
|---|---|
| `5.8.9` | moves with every rebuild |
| `5.8.9-r3` | one rebuild, never moves |
| `5.8.9-20261127` | the last build of that day |
| `sha-1a2b3c4` | the build of that commit of this repository |
| `latest` | the newest build |

A daily job checks the published image and rebuilds it without cache only if `apt-get upgrade` would change packages or the pinned base image changed (label `org.opencontainers.image.base.digest`); otherwise the digest stays. Builds are smoke-tested ([`test/smoke.sh`](test/smoke.sh)) before they are pushed, with build provenance and SBOM.

Pin a digest if you want to decide yourself when an update arrives.

## License

The files in this repository are under the [Apache License 2.0](LICENSE), as EMQX 5.8.9 itself.
