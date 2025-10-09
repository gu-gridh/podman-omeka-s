#!/usr/bin/env bash
set -euo pipefail

path="$1"
repo="$2"
name="$3"
version="$4"
need_comp="${5:-}"  # pass "composer" to force composer install

zip="/tmp/${name}.zip"

if [[ "$repo" == "Daniel-KM" ]]; then
  url="https://gitlab.com/Daniel-KM/Omeka-S-module-${name}/-/archive/${version}/Omeka-S-module-${name}-${version}.zip"
elif [[ "repo" == "omeka-s-themes" ]]; then
  url="https://github.com/omeka-s-themes/${name}/releases/download/v${version}/${name}-${version}.zip"
else
  url="https://github.com/omeka-s-modules/${name}/releases/download/v${version}/${name}-${version}.zip"
fi

curl -fsSL "$url" --output "$zip"
unzip -q "$zip" -d "$path"

if [[ "$repo" == "Daniel-KM" ]]; then
  mv "${path}/Omeka-S-module-${name}-${version}" "${path}/${name}"
fi

if [[ "$need_comp" == "composer" ]]; then
  composer update
  composer --working-dir="${path}/${name}" install --no-dev
fi

rm "$zip"
