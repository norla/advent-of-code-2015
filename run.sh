#!/bin/bash
set -e
DAY=$1
mix run -e "Solution${DAY}.run" -e < input/${DAY}.txt
