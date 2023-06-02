#!/usr/bin/env bash

cat ./../.env | \
   sed '/^[[:blank:]]*$/d' | \
   sed '/^[[:blank:]]*#/d' | \
   sed 's/^\(.*\)$/export \1/' | \
   sed 's/"/\\"/' | \
   sed 's/\$/\\$/' | \
   sed 's/export \(.*\)=\(.*\)/export \1="\2"/' \
   > \
   /tmp/.docker-environment.sh
