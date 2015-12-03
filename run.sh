#!/bin/bash
set -e
DAY=$1
elixir -r src/solution-${DAY}.ex -e "Solution${DAY}.run" < input/${DAY}.txt
