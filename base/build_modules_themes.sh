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
elif [[ "$repo" == "BibLibre" ]]; then
  url="https://github.com/biblibre/omeka-s-module-${name}/archive/refs/tags/v${version}.zip"
elif [[ "$repo" == "Libnamic" ]]; then
  url="https://github.com/Libnamic/Omeka-S-${name}/archive/refs/tags/v${version}.zip"
elif [[ "$repo" == "didoc" ]]; then
  url="https://github.com/gu-gridh/thanksroy/archive/refs/heads/didoc.zip"
elif [[ "$repo" == "omeka-s-themes" ]]; then
  url="https://github.com/omeka-s-themes/${name}/archive/refs/tags/v${version}.zip"
elif [[ "$name" == "CopyResources" || "$name" == "Datavis" ]]; then
  url="https://github.com/omeka-s-modules/${name}/archive/refs/tags/v${version}.zip"
elif [[ "$repo" == "gu-gridh" ]]; then
  url="https://github.com/${repo}/${name}/archive/refs/heads/${version}.zip"
else
  url="https://github.com/omeka-s-modules/${name}/releases/download/v${version}/${name}-${version}.zip"
fi

echo "Loading ${name} via ${url}..."
curl -fsSL "$url" --output "$zip"
unzip -q "$zip" -d "$path"

if [[ "$repo" == "Daniel-KM" ]]; then
  mv "${path}/Omeka-S-module-${name}-${version}" "${path}/${name}"
elif [[ "$repo" == "BibLibre" ]]; then
  mv "${path}/omeka-s-module-${name}-${version}" "${path}/${name}"
elif [[ "$repo" == "omeka-s-themes" || "$name" == "CopyResources" || "$name" == "Datavis" ]]; then
  mv "${path}/${name}-${version}" "${path}/${name}"
elif [[ "$repo" == "didoc" ]]; then
  mv "${path}/thanksroy-didoc" "${path}/${name}"
elif [[ "$repo" == "gu-gridh" && "$version" == "gridh" ]]; then
  mv "${path}/${name}-gridh" "${path}/gridh"
elif [[ "$repo" == "gu-gridh" && "$version" == "ostindiska" ]]; then
  mv "${path}/${name}-ostindiska" "${path}/gridh"
elif [[ "$repo" == "gu-gridh" && "$name" == "Omeka-S-module-AnnotationProfiles" ]]; then
  mv "${path}/${name}-main" "${path}/AnnotationProfiles"
fi

if [[ "$need_comp" == "composer" ]]; then
  # composer update
  echo "Running composer for {$name}..."
  composer --working-dir="${path}/${name}" install --no-dev --no-interaction --prefer-dist --no-progress
fi

rm "$zip"
