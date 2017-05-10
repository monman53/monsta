#!/bin/bash

# header
echo "<!doctype html>"
echo "<meta name='viewport' content='width=device-width, initial-scale=1'>"
echo "<meta charset='utf-8'>"

# scripts
echo "<script src='/js/asciidoc.js'></script>"
echo "<script src='/js/toc.js'></script>"

# title
title=$(head -n 1 $1)
echo "<title>$title</title>"
echo "<h1>$title</h1>"
echo "<a href='/'>Top</a>"
echo "<hr>"
