#!/usr/bin/env bash
set -euo pipefail
NAME=$(basename "$(pwd)")
GIT_SHA=$(git rev-parse --short=8 HEAD)
CACHE_DIR="/var/cache/image-builds"
TMP=$(mktemp -d) || { echo "Failed to create temp directory"; exit 1; }
trap 'rm -rf ${TMP}' EXIT

ARCHIVE_NAME="${NAME}-${GIT_SHA}.tar"
TMP_PATH="${TMP}/${ARCHIVE_NAME}"

[[ -d "${CACHE_DIR}" ]] || sudo mkdir -p "${CACHE_DIR}"
echo "Building image ${NAME}..."
buildah bud -f Containerfile -t "${NAME}" || { echo "Build failed"; exit 1; }
echo "Tagging ${NAME}:latest"
buildah tag "${NAME}" "${NAME}:latest"
echo "Tagging ${NAME}:${GIT_SHA}"
buildah tag "${NAME}" "${NAME}:${GIT_SHA}"
echo "Archiving image..."
buildah push "${NAME}:latest" "oci-archive:${TMP_PATH}" &&
    sudo cp "${TMP_PATH}" "${CACHE_DIR}/${ARCHIVE_NAME}" &&
    echo "Image cached at ${CACHE_DIR}/${ARCHIVE_NAME}" ||
    { echo "Failed to archive image"; exit 1; }
