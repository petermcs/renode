#!/bin/bash

set -e
set -u

#change dir to script location
cd "${0%/*}"
. common_make_packages.sh

# create MacOS app structure
MACOS_APP_DIR=Renode.app
mkdir -p $MACOS_APP_DIR/Contents/{MacOS,Resources}/

DIR=$MACOS_APP_DIR/Contents/MacOS

. common_copy_files.sh

cp macos/macos_run.* $MACOS_APP_DIR/Contents/MacOS
cp macos/Info.plist $MACOS_APP_DIR/Contents/
cp macos/renode.icns $MACOS_APP_DIR/Contents/Resources #Made with png2icns

hdiutil create -volname Renode_$VERSION -srcfolder $MACOS_APP_DIR -ov -format UDZO renode_$VERSION.dmg

#cleanup unless user requests otherwise
if $REMOVE_WORKDIR
then
  rm -rf $MACOS_APP_DIR
fi
