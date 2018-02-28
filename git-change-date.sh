REF_TO_UPDATE=$1
REF_WITH_DATE=$2

COMMIT_HASH=`git show -s --format="%H" $REF_TO_UPDATE`
NEW_DATE=`git show -s --format=%ci $REF_WITH_DATE`

echo "Following command will update $COMMIT_HASH to $NEW_DATE"

read -d '' COMMAND <<- EOF
git filter-branch -f --env-filter 'if [ \$GIT_COMMIT = $COMMIT_HASH ]; then export GIT_AUTHOR_DATE="$NEW_DATE"; export GIT_COMMITTER_DATE="$NEW_DATE"; fi'
EOF

echo $COMMAND
$COMMAND
