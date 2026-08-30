#!/bin/sh
printf '\033c\033]0;%s\a' SGJ_Tower_Defense
base_path="$(dirname "$(realpath "$0")")"
"$base_path/SGJ_Tower_Defense.x86_64" "$@"
