#!/bin/sh


## FUNCTION
sanitize() {
  if [ -z "${1}" ]; then
    >&2 echo "Unable to find the ${2}. Did you set with.${2}?"
    exit 1
  fi
}


#### MAIN
main(){
    sanitize "${INPUT_RELEASE_ID}" "Release ID"
    FILE=${INPUT_FILENAME}
    curl   -X POST   -H "Authorization: token $INPUT_GITHUB_TOKEN"  -H "Content-Type: $(file -b --mime-type $FILE)"   --data-binary @$FILE    "https://uploads.github.com/repos/${INPUT_COMPANY}/${INPUT_REPO}/releases/${INPUT_RELEASE_ID}/assets?name=$FILE"

}


main
