#!/bin/bash

# Function to display help message
show_help() {
    echo "Usage: $0 [OPTIONS] PATTERN FILE"
    echo "Search for PATTERN in FILE"
    echo ""
    echo "Options:"
    echo "  -n          Show line numbers"
    echo "  -v          Invert match (show non-matching lines)"
    echo "  --help      Show this help message"
    exit 1
}

# Check if help flag is provided
if [[ "$1" == "--help" ]]; then
    show_help
fi

show_line_numbers=0
invert_match=0
pattern=""
file=""

# Parse options
if [[ "$1" == "-n" ]]; then
    show_line_numbers=1
    shift
elif [[ "$1" == "-v" ]]; then
    invert_match=1
    shift
elif [[ "$1" == "-nv" || "$1" == "-vn" ]]; then
    show_line_numbers=1
    invert_match=1
    shift
fi

# Assign pattern and file arguments
pattern="$1"
file="$2"

# Validate input arguments
if [[ -z "$pattern" ]]; then
    echo "Error: Missing search pattern"
    show_help
fi

if [[ -z "$file" ]]; then
    echo "Error: Missing filename"
    show_help
fi

if [[ ! -f "$file" ]]; then
    echo "Error: File '$file' not found"
    exit 1
fi

# Convert pattern to lowercase for case-insensitive matching
pattern_lower=$(echo "$pattern" | tr '[:upper:]' '[:lower:]')

# process matches
line_num=1
while IFS= read -r line; do
    line_lower=$(echo "$line" | tr '[:upper:]' '[:lower:]')
    if [[ "$line_lower" == *"$pattern_lower"* ]]; then
        if [[ $invert_match -eq 0 ]]; then
            if [[ $show_line_numbers -eq 1 ]]; then
                echo "$line_num:$line"
            else
                echo "$line"
            fi
        fi
    else
        if [[ $invert_match -eq 1 ]]; then
            if [[ $show_line_numbers -eq 1 ]]; then
                echo "$line_num:$line"
            else
                echo "$line"
            fi
        fi
    fi
    line_num=$((line_num + 1))
done < "$file"