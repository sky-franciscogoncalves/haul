#!/usr/bin/env bash

THIS_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

[ ! -z "$SCRIPT_SRC" ] && SCRIPT_SRC="${THIS_DIR}/../../../${SCRIPT_SRC}"

# Check if custom script source was passed and exists
if [ ! -d "${SCRIPT_SRC}" ]; then
    SCRIPT_SRC="${THIS_DIR}/../../../react-native/packager"
fi

# Check if react-native/packager exists, for React Native < 0.46
if [ ! -d "${SCRIPT_SRC}" ]; then
  SCRIPT_SRC="${THIS_DIR}/../../../react-native/scripts"
fi

SRC="$(cd "${SCRIPT_SRC}" && pwd)"

# Replace local-cli with Haul in `react-native-xcode.sh`
sed -i -e 's|$REACT_NATIVE_DIR/local-cli/cli.js|./node_modules/.bin/haul|' ${SRC}/react-native-xcode.sh

# Replace `react-native start` in `packager.sh`
PACKAGER_CONTENT="cd \"$THIS_DIR/../../../../\" && node \"./node_modules/.bin/haul\" start --platform ios $@"
echo "$PACKAGER_CONTENT" > ${SRC}/packager.sh
