#!/usr/bin/env bash

###############################################################################
# This script parses the youtube rss feed and creates a new post for each video.
# It takes a single argument, the url of the feed
###############################################################################
# Usage:
#   ./new_post_from_feed.sh "https://www.youtube.com/feeds/videos.xml?channel_id=ABCD"
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
CONTENT_UPDATED=$FORCE_DEPLOY

if [ -z "$FEED_URL" ]; then
  echo "Usage: ./new_post_from_feed.sh \"https://www.youtube.com/feeds/videos.xml?channel_id=ABCD\""
  exit 1
fi

# Get the machine's temporary folder
echo ":::INFO::: Creating temporary folder"
TMP_DIR="$(mktemp -d)"
echo "    Temporary folder: ${TMP_DIR}"

# Download the feed
echo ":::INFO::: Downloading feed"
curl -s "$FEED_URL" > "${TMP_DIR}/feed.xml"
echo "    Feed downloaded to: ${TMP_DIR}/feed.xml"

# Loop through each entry in the feed
COUNT="$(xpath -q -e "count(//entry/title)" "${TMP_DIR}/feed.xml")"
echo ":::INFO::: Found ${COUNT} entries in the feed"
# For loop in bash
for ((i=1; i<=COUNT; i++))
do
    # Parse the feed and get the latest entry only
    echo ":::INFO::: Parsing feed"
    ENTRY_TITLE="$(xpath -q -e "//entry[${i}]/title/text()" "${TMP_DIR}/feed.xml")"
    ENTRY_DESCRIPTION="$(xpath -q -e "//entry[${i}]/media:group/media:description/text()" "${TMP_DIR}/feed.xml")"
    ENTRY_PUBLISHED="$(xpath -q -e "//entry[${i}]/published/text()" "${TMP_DIR}/feed.xml")"
    # Extract YYYY-MM-DD from the published date
    ENTRY_DATE="$(echo "${ENTRY_PUBLISHED}" | cut -d "T" -f 1)"
    ENTRY_URL="$(xpath -q -e "//entry[${i}]/link/@href" "${TMP_DIR}/feed.xml" | sed -e 's/href=//g')"

    # Remove all non-alphanumeric characters from the title
    # Replace spaces with dashes in the title
    # and convert to lowercase
    FILENAME="$(echo \""${ENTRY_TITLE}\"" | sed -e 's/[^[:alnum:] ]//g' | sed -e 's/ /-/g' | tr '[:upper:]' '[:lower:]')"

    # If _posts directory doesn't exist, create it
    if [ ! -d "${DIR}/../_posts" ]; then
        echo ":::INFO::: Creating _posts directory"
        mkdir "${DIR}/../_posts"
    fi

    # If the file exists already, exit without an error
    if [ -f "${DIR}/../_posts/${ENTRY_DATE}-${FILENAME}.md" ]; then
        echo ":::INFO::: Post already exists, nothing to do here. Exiting"
        continue
    fi

    CONTENT_UPDATED=true

    # Replace all urls in the entry description with markdown links
    ENTRY_DESCRIPTION="$(echo "${ENTRY_DESCRIPTION}" | sed -e 's/\(http[s]*:\/\/[^\S ]*\)/[\1](\1)/g')"

    # Create the file
    echo ":::INFO::: Creating post file"
    echo "    ${DIR}/../_posts/${ENTRY_DATE}-${FILENAME}.md"
    touch "${DIR}/../_posts/${ENTRY_DATE}-${FILENAME}.md"

    # Write the front matter to the file
    echo ":::INFO::: Writing front matter to the post file"
    cat <<EOF > "${DIR}/../_posts/${ENTRY_DATE}-${FILENAME}.md"
---
layout: post
title:  "${ENTRY_TITLE}"
date:   "${ENTRY_PUBLISHED}"
categories: youtube
---
EOF

    # Write the description to the file and embed the youtube video
    echo ":::INFO::: Writing details to the post file"
    cat <<EOF >> "${DIR}/../_posts/${ENTRY_DATE}-${FILENAME}.md"
{% youtube ${ENTRY_URL} %}
{% include anchor-embed.html %}
<br />
${ENTRY_DESCRIPTION}
EOF
done

# Remove the temporary folder
echo ":::INFO::: Removing temporary folder"
rm -rf "${TMP_DIR}"

# Set the job outputs
echo "content_updated=${CONTENT_UPDATED}" >> $GITHUB_OUTPUT
