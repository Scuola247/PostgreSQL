#!/bin/bash
# 
# cerca ed esegue i file indicati dall'opzione -name a partire dal path indicato come primo parametro
#
find ./ -name create.sql -exec psql -h postgresql -U postgres -d scuola247 -f {} ';'
