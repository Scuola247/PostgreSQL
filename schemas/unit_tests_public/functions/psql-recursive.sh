#!/bin/bash
#
# cerca ed esegue i file indicati dall'opzione -name a partire dal path indicato come primo parametro
#
find ./ -name create.sql -exec /Users/dongwenren/PostgreSQL/pg96/bin/psql -h scuola247 -U postgres -d scuola247 -f {} ';'
