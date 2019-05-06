#!/usr/bin/env bash

rm -rf ./src/assets || echo 'no src/assets'
rm -rf ./dist || echo 'no dist'
mkdir ./dist

cat ./assets.list | while read line
do
  echo "downloading $line..."
  mkdir -p "src/assets/$(dirname $line)"
  curl "https://$BASIC_AUTH_USER:$BASIC_AUTH_PASS@$DOWNLOAD_HOST/$DOWNLOAD_DIR/$line" > "src/assets/$line"
done

cat ./html.list | while read line
do
  echo "downloading $line.html..."
  key=$(echo $line | cut -f 1 -d '=')
  value=$(echo $line | cut -f 2 -d '=')
  curl "https://$BASIC_AUTH_USER:$BASIC_AUTH_PASS@$DOWNLOAD_HOST/$value" > "./dist/$key.html"
done
