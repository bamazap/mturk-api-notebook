for f in ./*.ipynb; do
    mv "$f" "$f"~
    jq --indent 1 \
        '
        (.cells[] | select(has("outputs")) | .outputs) = []
        | (.cells[] | select(has("execution_count")) | .execution_count) = null
        | .metadata = {"language_info": {"name":"python", "pygments_lexer": "ipython3"}}
        | .cells[].metadata = {}
        ' "$f"~ > "$f"
    rm "$f"~
done
