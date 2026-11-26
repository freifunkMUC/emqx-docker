#!/usr/bin/env bash
# Starts the image as upstream documents it and checks that the node comes up,
# the MQTT listener runs and no Debian upgrades are pending.
# Usage: test/smoke.sh <image>
set -euo pipefail

image=${1:?usage: $0 <image>}
name=emqx-smoke-$$

cleanup() { docker rm -f "$name" >/dev/null 2>&1 || true; }
trap cleanup EXIT
fail() { echo "FAIL: $*" >&2; docker logs "$name" 2>&1 | tail -20 >&2 || true; exit 1; }

docker run -d --name "$name" "$image" >/dev/null
for _ in $(seq 60); do
  docker exec "$name" emqx ctl status 2>/dev/null | grep -q 'is started' && break
  sleep 2
done
docker exec "$name" emqx ctl status | grep -q 'is started' || fail "node did not start"
echo "ok   node started"

docker exec "$name" emqx ctl listeners | grep -A8 '^tcp:default' | grep -q 'running *: true' || fail "tcp listener not running"
echo "ok   tcp listener"

[ "$(docker exec "$name" id -un)" = emqx ] || fail "not running as emqx"
echo "ok   user emqx"

pending=$(docker run --rm --user 0 --entrypoint bash "$image" \
  -c 'apt-get -qq --error-on=any update >/dev/null && apt-get -s upgrade' | grep -c '^Inst ' || true)
[ "$pending" -eq 0 ] || fail "$pending upgrades pending"
echo "ok   no pending upgrades"
