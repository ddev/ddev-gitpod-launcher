#!/bin/bash

set -eu 

# Set up a given DDEV_REPO repository in gitpod (default to d9simple)
# Run composer install if there's a composer.json
# Import artifacts if there's a ${DDEV_REPO}-artifacts repository that can be checked out
export DDEV_REPO=${DDEV_REPO:-https://github.com/drud/d9simple}
echo "Checking out repository ${DDEV_REPO}"
DEFAULT_ARTIFACTS="${DDEV_REPO}-artifacts"
export DDEV_ARTIFACTS=${DDEV_ARTIFACTS:-$DEFAULT_ARTIFACTS}
echo "Attempting to get artifacts from ${DDEV_ARTIFACTS}"
git clone ${DDEV_ARTIFACTS} "/tmp/${DDEV_ARTIFACTS##*/}" || echo "Could not check out artifacts repo ${DDEV_ARTIFACTS}"
reponame=${DDEV_REPO##*/}
reponame="${reponame//_/-}"
git clone ${DDEV_REPO} ${GITPOD_REPO_ROOT}/${reponame}
if [ -d ${GITPOD_REPO_ROOT}/${reponame} ]; then
  "$GITPOD_REPO_ROOT"/.gitpod/setup_vscode_git.sh
  cd ${GITPOD_REPO_ROOT}/${reponame}
  # Temporarily use an empty config.yaml to get ddev to use defaults
  # so we can do composer install. If there's already one there, 
  # this does no harm.
  mkdir -p .ddev && touch .ddev/config.yaml

  # If there's a composer.json, do `ddev composer install` (which auto-starts projct)
  if [ -f composer.json ]; then
    ddev start
    ddev composer install
  fi
  # Now that composer install has been done, if we were using an empty
  # .ddev/config.yaml, we'll do a real ddev config
  if [ ! -s .ddev/config.yaml ]; then
    ddev config --project-name="${reponame}"
  fi
  # This won't be required in ddev v1.18.2+
  printf "host_webserver_port: 8080\nhost_https_port: 2222\nhost_db_port: 3306\nhost_mailhog_port: 8025\nhost_phpmyadmin_port: 8036\nbind_all_interfaces: true\n" >.ddev/config.gitpod.yaml
  ddev stop -a
  ddev start -y
  if [ -d "/tmp/${DDEV_ARTIFACTS##*/}" ]; then
    if [ -f "/tmp/${DDEV_ARTIFACTS##*/}/db.sql.gz" ]; then
      ddev import-db --src=/tmp/${DDEV_ARTIFACTS##*/}/db.sql.gz
    else
      echo "No db.sql.gz was provided in /tmp/${DDEV_ARTIFACTS##*/}"
    fi
    if [ -f "/tmp/${DDEV_ARTIFACTS##*/}/files.tgz" ]; then
      ddev import-files --src=/tmp/${DDEV_ARTIFACTS##*/}/files.tgz
    else
      echo "No files.tgz was provided in /tmp/${DDEV_ARTIFACTS##*/}"
    fi
  fi
  gp await-port 8080 && sleep 1 && gp preview $(gp url 8080)
else
  echo "Failed to clone ${DDEV_REPO}, not starting project"
fi
