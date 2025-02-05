source $(dirname "${0}")/functions_library.sh

# Parameters definition
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
IMGREG='registry-1.docker.io/wtout'
AUTHFILE="${HOME}/.podman/auth.json"
