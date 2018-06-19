#!/bin/bash
echo > ./${0##*/}.sql
find . -name $1.sql -exec cat {} >>/tmp/${0##*/}.sql +

