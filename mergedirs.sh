# shellcheck shell=bash
shopt -s nullglob
"${mkdir?}" -- "${out?}"
for arg in "$@"; do
    for file in "$arg"/*; do
        "${ln?}" "$file" -sft "$out"
    done
done