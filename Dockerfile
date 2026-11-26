# EMQX 5.8.9, the last release under Apache-2.0 (5.9 and later are BSL), with
# the Debian security updates its upstream image no longer gets. Nothing else
# changes: same user, entrypoint, ports and configuration. See README.md.
FROM docker.io/emqx/emqx:5.8.9@sha256:35b46f7aa7a0d51f3959e4344221ac5ec7f948b03e43099286b6c40a07bb393b

USER root
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
 && rm -rf /var/lib/apt/lists/*
USER emqx
