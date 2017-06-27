#!/bin/bash

parallel echo {.} ::: `find ./root -name '*.adoc'` | sort > _adocs
parallel echo {.} ::: `find ./root -name '*.html'` | sort > _htmls

rms=`comm -13 _adocs _htmls | awk '{print $1".html"}'`

rm -i ${rms}

rm _adocs
rm _htmls
