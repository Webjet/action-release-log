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

    sanitize "${INPUT_GITHUB_TOKEN}" "Github-access-token"
    echo "repo: ${INPUT_REPOSITORY:-${GITHUB_REPOSITORY}}"
    echo "RUN ID: ${INPUT_RUN_ID:-${GITHUB_RUN_ID}}"
    
    ## OPTION1: WHOLE RUN LOG
    ## ! Can't download run log while build not finished
    # curl -v -L -u octocat:${INPUT_GITHUB_TOKEN} -o ${INPUT_FILENAME} "https://api.github.com/repos/${INPUT_COMPANY}/${INPUT_REPO}/actions/runs/${INPUT_RUNID}/logs"
    # curl -v -L -u octocat:${INPUT_GITHUB_TOKEN} -o ${INPUT_FILENAME} "https://api.github.com/repos/Kevin-Li-Webjet/Git-Action-Test/actions/runs/228240146/logs" # TEST OK
    
    ## OPTION2: JOB LOG
    # Get Job ID
    GITHUB_BASEURL=https://api.github.com
    GITHUB_API="/repos/${INPUT_REPOSITORY:-${GITHUB_REPOSITORY}}/actions/runs/${INPUT_RUN_ID:-${GITHUB_RUN_ID}}/jobs"
    eval "$(curl --get -Ss -H "Authorization: token ${INPUT_GITHUB_TOKEN}" -H "Accept: application/vnd.github.v3+json" "${GITHUB_BASEURL}${GITHUB_API}?per_page=30" \
    | jq -r --arg job_name "${INPUT_JOB_NAME}" '.jobs | map(select(.name == $job_name)) | .[0] | @sh "job_id=\(.id) html_url=\(.html_url)"')"
    
    echo "JOB ID: ${job_id}"
    # download
    curl -v -L -u octocat:${INPUT_GITHUB_TOKEN} -o ${INPUT_FILENAME} "${GITHUB_BASEURL}/repos/${INPUT_COMPANY}/${INPUT_REPO}/actions/jobs/${job_id}/logs"

}


main
