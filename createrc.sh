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
#Delete the old remote rc branch
deleteOldBranchRemote="git push origin --delete rc"
deleteOldBranchLocal="git branch -D rc"
#Reset the upstream branch for the new-name local branch.
resetUpstream="git push -u origin $newrcName"

${getRename}
${deleteOldBranchRemote}
${deleteOldBranchLocal}
${resetUpstream}

#######2 create the new branch#######

getCoMaster="git checkout master"
${getCoMaster}
${getLatest}

createNewRc="git checkout -b rc"
pushNewRc="git push -u origin rc"
${createNewRc}
${pushNewRc}
