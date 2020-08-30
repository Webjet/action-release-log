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
    
    ## OPTION1: WHOLE RUN LOG
    ## ! Can't download run log while build not finished
   # curl -v -L -u octocat:${INPUT_GITHUB_TOKEN} -o ${INPUT_FILENAME} "https://api.github.com/repos/${INPUT_COMPANY}/${INPUT_REPO}/actions/runs/${INPUT_RUNID}/logs"
    # curl -v -L -u octocat:${INPUT_GITHUB_TOKEN} -o ${INPUT_FILENAME} "https://api.github.com/repos/Kevin-Li-Webjet/Git-Action-Test/actions/runs/228240146/logs" # TEST OK
    
    ## OPTION2: JOB LOG
    curl -v -L -u octocat:${INPUT_GITHUB_TOKEN} -o ${INPUT_FILENAME} "https://api.github.com/repos/${INPUT_COMPANY}/${INPUT_REPO}/actions/jobs/${INPUT_JOBID}/logs"

}


main
