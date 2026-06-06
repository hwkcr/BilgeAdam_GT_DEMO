#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/jenkins-home"

if ! pgrep -f 'java -jar .*jenkins.war --httpPort=8080' >/dev/null 2>&1; then
  if [ ! -f "$HOME/jenkins.war" ]; then
    curl -L -o "$HOME/jenkins.war" https://get.jenkins.io/war-stable/latest/jenkins.war
  fi

  nohup env JENKINS_HOME="$HOME/jenkins-home" \
    java -jar "$HOME/jenkins.war" \
    --httpPort=8080 \
    --httpListenAddress=0.0.0.0 \
    >/tmp/jenkins.log 2>&1 &

  echo $! > /tmp/jenkins.pid
fi

for i in $(seq 1 60); do
  if curl -sf http://127.0.0.1:8080/login >/dev/null 2>&1; then
    echo "Jenkins is ready"
    exit 0
  fi
  sleep 2
done

echo "Jenkins did not become ready in time" >&2
cat /tmp/jenkins.log 2>/dev/null || true
exit 1
