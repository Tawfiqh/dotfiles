#!/bin/bash
echo "Beginning" $1;
env PRODUCT_TO_BUILD=$1 gatsby build &&

if [ $1 = "landingPages" ]
then

  rm -rf landingPagePublic;

  mkdir landingPagePublic;
  cp -a public/ landingPagePublic/;

  # echo "Copying Cache";
  # mkdir landingPageCache;
  # cp -a .cache/data.json ./landingPageCache/
  # cp -a .cache/async-requires.js ./landingPageCache/
  echo "done";

fi


if [ $1 = "indexPages" ]
then

  echo "Merging index and Landing";

  rm -rf indexAndLandingPublic;

  mkdir indexAndLandingPublic;

  cp -a public/ indexAndLandingPublic/;
  echo "\n\n\n Copying landing pages:::: \n\n\n"
  cp -a landingPagePublic/ indexAndLandingPublic/;

  echo "done merged index and Landing";

  cp -a indexAndLandingPublic/ public/;

  echo "Overwritten public with indexAndlandingPages";

fi
