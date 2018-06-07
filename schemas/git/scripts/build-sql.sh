#!/bin/bash
rm /tmp/fol.sql
find . -name create.sql -exec cat {} >>/tmp/fol.sql +
cp /tmp/fol.sql .
