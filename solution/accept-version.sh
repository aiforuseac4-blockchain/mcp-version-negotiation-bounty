#!/bin/sh
# accept-version.sh <requested> <client-supported-csv> <server-selected>
# Exit 0 and print selected version only if both requested and selected
# are exact whole tokens in the client's comma-separated supported list.

set -e

requested="$1"
client_supported="$2"
server_selected="$3"

# Check if a version is an exact whole token in the comma-separated list
is_supported() {
    version="$1"
    supported_list="$2"
    
    # Add commas around the list for exact matching
    # This prevents substring matches like "2025-06-18" matching "2025-06-18-preview"
    case ",${supported_list}," in
        *,${version},*)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Both requested and selected must be exact members of the supported list
if is_supported "$requested" "$client_supported" && is_supported "$server_selected" "$client_supported"; then
    printf '%s\n' "$server_selected"
    exit 0
else
    exit 1
fi
