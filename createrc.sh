# ABOUT
# createrc.sh:  This script assumes you create a new rc branch with every release.
# Long living branches are evil.  This script creates a fresh rc branch based off of master.
# The intention is to run this script with each new release
# The script runs in 2 steps.
# Step 1:
#        - rename the current rc branch to rcDATE_STAMP
#        - if rename successful, delete current rc from local and remote
# Step 2:
#         - create a new rc branch based off the latest version of master
# argument 1: put the script into test mode.  E.G. createrc.sh test
# Test mode:  assumes rc branch does not exist.  It will simply create a new rc branch for you.
# Test mode:  I did not add a delete function to test mode for safety purposes in a production environment

##Testing##
if [ $1 ]
  then
    #test assumes rc branch does not exist.  It creates a new rc branch
	echo "Test mode enabled."
  goToMaster="git checkout master"
  createRc="git checkout -b rc"
  pushRcRemote="git push -u origin rc"
  ${goToMaster}
  ${createRc}
  ${pushRcRemote}
fi

#######1 rename the old rc branch#####
gitCo="git checkout rc"
getLatest="git pull"
${gitCo}
${getLatest}

#get todays date for use with renaming rc
Now_hourly=$(date +%d%b%H%M)
#echo "$Now_hourly"

newrcName="rc$Now_hourly"
#echo "$newrcName"

#rename rc to the new name
gitRename="git branch -m $newrcName"
#Delete the old remote rc branch
deleteOldBranchRemote="git push origin --delete rc"
deleteOldBranchLocal="git branch -D rc"
#Reset the upstream branch for the new-name local branch.
resetUpstream="git push -u origin $newrcName"

${gitRename}
# $? contains the exit code of the preceding echo
BRANCH_EXIT_CODE=$?
if [ $BRANCH_EXIT_CODE -eq 0 ];
  then
    ${deleteOldBranchRemote}
    ${deleteOldBranchLocal}
  else
    echo "Skipping rc cleanup.  Error during git rename.  exit code was $BRANCH_EXIT_CODE"
fi

${resetUpstream}

#######2 create the new branch#######

getCoMaster="git checkout master"
${gitCoMaster}
${getLatest}

createNewRc="git checkout -b rc"
pushNewRc="git push -u origin rc"
${createNewRc}
${pushNewRc}
