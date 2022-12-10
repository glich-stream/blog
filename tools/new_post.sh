#!/usr/bin/env bash

###############################################################################
# This script creates a new post in the _posts directory.
# It takes a single argument, the title of the post.
# It will create a file with the current date and the title as the filename.
# It will also add the title and date to the front matter of the file.
###############################################################################
# Usage:
#   ./new_post.sh "My New Post"
###############################################################################
# Requirements:
#   - bash
#   - date
#   - sed
###############################################################################

set -e # exit on error

TITLE="$1"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z "$TITLE" ]; then
  echo "Usage: ./new_post.sh \"My New Post\""
  exit 1
fi

# Get the current date in the format YYYY-MM-DD
DATE=$(date -u +"%Y-%m-%d")
# Get the current date in the format YYYY-MM-DD HH:MM:SS +/-TTTT
FULL_DATE=$(date -u +"%Y-%m-%d %H:%M:%S %z")

# Remove all non-alphanumeric characters from the title
# Replace spaces with dashes in the title
# and convert to lowercase
FILENAME="$(echo \""${TITLE}\"" | sed -e 's/[^[:alnum:] ]//g' | sed -e 's/ /-/g' | tr '[:upper:]' '[:lower:]')"

# If _posts directory doesn't exist, create it
if [ ! -d "${DIR}/../_posts" ]; then
  mkdir "${DIR}/../_posts"
fi

# Create the file
touch "${DIR}/../_posts/${DATE}-${FILENAME}.md"

# Add the front matter to the file
cat <<EOF > "${DIR}/../_posts/${DATE}-${FILENAME}.md"
---
layout: post
title:  "${TITLE}"
date:   "${FULL_DATE}"
categories:
---
EOF
