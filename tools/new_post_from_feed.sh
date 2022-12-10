#!/usr/bin/env bash

###############################################################################
# This script parses the youtube rss feed and creates a new post for each video.
# It takes a single argument, the url of the feed
###############################################################################
# Usage:
#   ./new_post_from_feed.sh "https://www.youtube.com/feeds/videos.xml?channel_id=UCJZv4d5rbIKd4QHMPkcABCw"
###############################################################################
# Requirements:
#   - bash
#   - date
#   - sed
#   - curl
#   - xpath
###############################################################################

set -e # exit on error

FEED_URL="$1"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z "$FEED_URL" ]; then
  echo "Usage: ./new_post_from_feed.sh \"https://www.youtube.com/feeds/videos.xml?channel_id=UCJZv4d5rbIKd4QHMPkcABCw\""
  exit 1
fi

# Get the machine's temporary folder
echo "::: Creating temporary folder"
TMP_DIR="$(mktemp -d)"
echo "    Temporary folder: ${TMP_DIR}"

# Download the feed
echo "::: Downloading feed"
curl -s "$FEED_URL" > "${TMP_DIR}/feed.xml"
echo "    Feed downloaded to: ${TMP_DIR}/feed.xml"

# Parse the feed and get the latest entry only
echo "::: Parsing feed"
ENTRY_TITLE="$(xpath -q -e "//entry[1]/title/text()" "${TMP_DIR}/feed.xml")"
ENTRY_DESCRIPTION="$(xpath -q -e "//entry[1]/media:group/media:description/text()" "${TMP_DIR}/feed.xml")"
ENTRY_PUBLISHED="$(xpath -q -e "//entry[1]/published/text()" "${TMP_DIR}/feed.xml")"
ENTRY_URL="$(xpath -q -e "//entry[1]/link/@href" "${TMP_DIR}/feed.xml" | sed -e 's/href=//g')"

# Get the current date in the format YYYY-MM-DD
DATE=$(date -u +"%Y-%m-%d")

# Remove all non-alphanumeric characters from the title
# Replace spaces with dashes in the title
# and convert to lowercase
FILENAME="$(echo \""${ENTRY_TITLE}\"" | sed -e 's/[^[:alnum:] ]//g' | sed -e 's/ /-/g' | tr '[:upper:]' '[:lower:]')"

# If _posts directory doesn't exist, create it
if [ ! -d "${DIR}/../_posts" ]; then
    echo "::: Creating _posts directory"
    mkdir "${DIR}/../_posts"
fi

# If the file exists already, exit without an error
if [ -f "${DIR}/../_posts/${DATE}-${FILENAME}.md" ]; then
    echo "::: Post already exists, nothing to do here. Exiting"
    exit 0
fi

# Replace all urls in the entry description with markdown links
ENTRY_DESCRIPTION="$(echo "${ENTRY_DESCRIPTION}" | sed -e 's/\(http[s]*:\/\/[^\S ]*\)/[\1](\1)/g')"

# Create the file
echo "::: Creating post file"
echo "    ${DIR}/../_posts/${DATE}-${FILENAME}.md"
touch "${DIR}/../_posts/${DATE}-${FILENAME}.md"

# Write the front matter to the file
echo "::: Writing front matter to the post file"
cat <<EOF > "${DIR}/../_posts/${DATE}-${FILENAME}.md"
---
layout: post
title:  '${ENTRY_TITLE}'
date:   '${ENTRY_PUBLISHED}'
categories: youtube
---
EOF

# Write the description to the file and embed the youtube video
echo "::: Writing details to the post file"
cat <<EOF >> "${DIR}/../_posts/${DATE}-${FILENAME}.md"
{% youtube ${ENTRY_URL} %}
<br />
${ENTRY_DESCRIPTION}
EOF

# Remove the temporary folder
echo "::: Removing temporary folder"
rm -rf "${TMP_DIR}"
