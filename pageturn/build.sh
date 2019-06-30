#!/bin/sh

set -e

rm -r ./dist || true
mkdir ./dist

$KOBOGCC ./src/pageturn.c -o ./dist/pageturn
