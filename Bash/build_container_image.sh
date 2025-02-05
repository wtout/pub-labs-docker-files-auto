#!/bin/bash
# Usage: bash build_container_image.sh <product> <version>

PRODUCT="${1}"
VERSION="${2}"

source $(dirname "${0}")/common_parameters.sh

$(docker_cmd) build -f Dockerfiles/${PRODUCT}-${VERSION}.Dockerfile -t ${PRODUCT} .
if [[ "${?}" -eq 0 ]]
then
    $(docker_cmd) tag ${PRODUCT} ${IMGREG}/${PRODUCT}:${VERSION}
    $(docker_cmd) push ${IMGREG}/${PRODUCT}:${VERSION} --authfile ${AUTHFILE}
fi