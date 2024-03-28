#!/bin/bash

input_file="/git-autopull/repo_urls.txt"
output_directory="/git-autopull"

stop() {
    echo "Exiting..."
    exit 0
}

trap stop SIGTERM

clone_repo() {
    url=$1
    output_dir=$2
    repo_name=$(basename "$url" | sed 's/\.git$//')
    output_path="$output_dir/$repo_name"

    if [ -d "$output_path" ]; then
        echo "Pulling '$repo_name'..."
        git -C "$output_path" pull 
    else
        echo "Cloning '$repo_name'..."
        git clone "$url" "$output_path"
    fi
}

update_repos() {

    while true; do
        while IFS= read -r url; do
            url=$(echo "$url" | tr -d '\r')
            if [ -n "$url" ]; then
                clone_repo "$url" "$output_directory"
            fi
        done < "$input_file"

        echo "Waiting for 1 hour..."
        sleep 3600
    done
    
}

update_repos &
task_pid=$!
wait $task_pid