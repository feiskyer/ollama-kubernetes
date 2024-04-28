#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail

REPO_ROOT=$(dirname "${BASH_SOURCE}")/../ollama-kubernetes
helm package ${REPO_ROOT} -d /tmp/ollama/
helm repo index /tmp/ollama/ --url https://feisky.xyz/ollama-kubernetes
helm repo index --merge index.yaml /tmp/ollama/ --url https://feisky.xyz/ollama-kubernetes
mv /tmp/ollama/*.tgz .
mv /tmp/ollama/*.yaml .
