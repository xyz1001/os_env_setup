#!/usr/bin/env bash

sed -i "s/enterprise=false/enterprise=true/g" "${HOME}/.nutstore/dist/conf/nutstore.properties"
