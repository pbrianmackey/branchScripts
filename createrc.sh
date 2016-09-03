##Testing##
if [ $1 ]
  then
	echo "Test mode enabled."
  goToMaster="git checkout master"
  createRc="git checkout -b rc"
  ${goToMaster}
  ${createRc}
fi

#######1 rename the old rc branch#####
getCo="git checkout rc"
getLatest="git pull"
${getCo}
${getLatest}

#get todays date for use with renaming rc
Now_hourly=$(date +%d%b%H%M)
#echo "$Now_hourly"

newrcName="rc$Now_hourly"
#echo "$newrcName"

#rename rc to the new name
getRename="git branch -m $newrcName"
#Delete the old-name remote branch and push the new-name local branch.
deleteOldBranch="git push origin :rc $newrcName"
#Reset the upstream branch for the new-name local branch.
resetUpstream="git push -u origin $newrcName"

${getRename}
${deleteOldBranch}
${resetUpstream}

#######2 create the new branch#######

getCoMaster="git checkout master"
${getCoMaster}
${getLatest}

createNewRc="git checkout -b rc"
pushNewRc="git push -u origin rc"
${createNewRc}
${pushNewRc}
