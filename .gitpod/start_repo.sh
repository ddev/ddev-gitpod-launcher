#!/bin/bash

set -eu

# Set up a given DDEV_REPO repository in gitpod (default to d10simple)
# Run composer install if there's a composer.json
# Import artifacts if there's a ${DDEV_REPO}-artifacts repository that can be checked out
export DDEV_REPO=${DDEV_REPO:-https://github.com/ddev/d10simple}
echo "Checking out repository ${DDEV_REPO}"
DEFAULT_ARTIFACTS="${DDEV_REPO}-artifacts"
export DDEV_ARTIFACTS=${DDEV_ARTIFACTS:-$DEFAULT_ARTIFACTS}
echo "Attempting to get artifacts from ${DDEV_ARTIFACTS}"
git clone ${DDEV_ARTIFACTS} "/tmp/${DDEV_ARTIFACTS##*/}" || echo "Could not check out artifacts repo ${DDEV_ARTIFACTS}"
REPO_NAME=${DDEV_REPO##*/}
export REPO_NAME="${REPO_NAME//_/-}"
REPO_HOME=/workspace/code
git clone ${DDEV_REPO} ${REPO_HOME}
cd ${REPO_HOME}

# Temporarily use an empty config.yaml to get ddev to use defaults
# so we can do composer install. If there's already one there,
# this does no harm.
mkdir -p .ddev && touch .ddev/config.yaml

# If there's a composer.json, do `ddev composer install` (which auto-starts projct)
if [ -f composer.json ]; then
  ddev composer install
fi
# Now that composer install has been done, if we were using an empty
# .ddev/config.yaml, we'll do a real ddev config
if [ ! -s .ddev/config.yaml ]; then
  ddev config --project-name="${REPO_NAME}"
fi
ddev stop -a
ddev start -y
if [ -d "/tmp/${DDEV_ARTIFACTS##*/}" ]; then
  if [ -f "/tmp/${DDEV_ARTIFACTS##*/}/db.sql.gz" ]; then
    ddev import-db --file=/tmp/${DDEV_ARTIFACTS##*/}/db.sql.gz
  else
    echo "No db.sql.gz was provided in /tmp/${DDEV_ARTIFACTS##*/}"
  fi
  if [ -f "/tmp/${DDEV_ARTIFACTS##*/}/files.tgz" ]; then
    ddev import-files --source=/tmp/${DDEV_ARTIFACTS##*/}/files.tgz
  else
    echo "No files.tgz was provided in /tmp/${DDEV_ARTIFACTS##*/}"
  fi
fi
gp ports await 8080 && sleep 1 && gp preview $(gp url 8080)
