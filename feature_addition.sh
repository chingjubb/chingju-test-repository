#!/bin/bash

echo "Feature branch: $1"
FEATURE_BRANCH=$1
echo "Merge $FEATURE_BRANCH to Dev"
git checkout dev
git merge $FEATURE_BRANCH

