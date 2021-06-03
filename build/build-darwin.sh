#!/bin/sh
source flags.sh

BUILD_DIR="../bin/${VERSION}/"

APP="${NAME}.app"

rm -rf ${BUILD_DIR}/"$APP"/
mkdir -p ${BUILD_DIR}/"$APP"/Contents/{MacOS,Resources}

GOOS=darwin GOARCH=amd64 go build -o ${BUILD_DIR}/"$APP"/Contents/MacOS/${NAME} -ldflags="${LDFLAGS}" ../main.go

cp ./darwin/Info.plist ${BUILD_DIR}/"${APP}"/Contents/Info.plist
cp ../icon/icon.icns ${BUILD_DIR}/"${APP}"/Contents/Resources/icon.icns

cd ${BUILD_DIR}

rm *.dmg
create-dmg --dmg-title="${NAME}" --overwrite "${APP}"
mv *.dmg ${NAME}_${VERSION}.dmg
rm -rf "${APP}"