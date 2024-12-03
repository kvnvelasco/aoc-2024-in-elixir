# List all day directories
list-days:
    @ls -d day_*

# Run a command in each day directory
# Usage: just run-in-days "your_command"
run-each-day command:
    #!/usr/bin/env bash
    for dir in day_*; do
        if [ -d "$dir" ]; then
            echo "Running in $dir..."
            cd "$dir"
            {{command}}
            cd ..
        fi
    done

test: (run-each-day "mix test")
