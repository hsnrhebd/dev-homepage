#!/bin/bash
set -e

echo "=== is-a.dev website build ==="
echo "Working directory: $(pwd)"
echo "Files:"
ls -la

echo "=== Checking ZIP ==="
if [ ! -f "is-a-dev-developer-site.zip" ]; then
  echo "ERROR: ZIP file not found."
  exit 1
fi

echo "ZIP size:"
du -h "is-a-dev-developer-site.zip"

echo "=== Preparing dist ==="
rm -rf dist
mkdir -p dist

echo "=== Extracting website ==="
python3 -c "import zipfile; zipfile.ZipFile('is-a-dev-developer-site.zip').extractall('dist')"

echo "=== Checking website ==="
if [ ! -f "dist/index.html" ]; then
  echo "ERROR: index.html was not found after extraction."
  echo "Extracted files:"
  find dist -maxdepth 3 -type f -print
  exit 1
fi

echo "=== Build successful ==="
echo "Website files:"
find dist -maxdepth 2 -type f -print
