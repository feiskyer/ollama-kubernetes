#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail

REPO_ROOT=$(realpath "$(dirname "${BASH_SOURCE}")/..")
RELEASE_ROOT="${REPO_ROOT}/.cache/releases/"

if [ -d ${REPO_ROOT}/.cache/releases ]; then
  rm -rf ${REPO_ROOT}/.cache/releases
fi

git clone https://github.com/feiskyer/ollama-kubernetes -b gh-pages ${REPO_ROOT}/.cache/releases
cp README.md ${REPO_ROOT}/.cache/releases/
cd ${REPO_ROOT}/.cache/releases

# Build helm releases
mkdir -p /tmp/ollama/
helm package ${REPO_ROOT} -d /tmp/ollama/
helm repo index /tmp/ollama/ --url https://feisky.xyz/ollama-kubernetes
helm repo index --merge index.yaml /tmp/ollama/ --url https://feisky.xyz/ollama-kubernetes
mv /tmp/ollama/*.tgz .
mv /tmp/ollama/*.yaml .

# Commit and push
git add -A .
git commit -a -m 'Update helm releases'
git remote set-url origin  https://feiskyer:${GITHUB_TOKEN}@github.com/feiskyer/ollama-kubernetes.git
git push -q -u origin gh-pages
