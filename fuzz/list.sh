#!/bin/bash

script_dir=$(dirname $(readlink -f "$0"))

echo "Building"

dune build

echo ""

echo "Fuzzing tests available:"

for file in $script_dir/../_build/default/fuzz/*.exe; do
  echo "- "$(basename $file)
done
