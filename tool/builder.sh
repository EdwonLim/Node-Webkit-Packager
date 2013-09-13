#!/bin/bash

printf 'Read Configuration File :\n'

while IFS== read key value Shell
do
    if [ $key = 'app_name' ]
    then
        name=$value
    elif [ $key = 'app_class' ]
    then
        className=$value
    elif [ $key = 'app_package' ]
    then
        packageName=$value
    elif [ $key = 'app_site' ]
    then
        site=$value
    fi
done < ../config/app.config

printf '  APPNAME : '$name'\n'
printf '  APPCLASS : '$packageName'.'$className'\n'
printf '  WEBSITE : '$site'\n'

cd ../

if [ -x build ]
then
    rm -r build/
fi
mkdir build/

pwd

if [ -x node-webkit/node-webkit.app ]
then
    printf 'Start Package Resources : \n'
    cd resources
    zip ../build/$name.nw *
    printf 'Package Resources Success : build/'$name'.nw\n'

    cd ../build

    printf 'Start Package App.\n'
    mv $name.nw app.nw

    cp ../config/mac/Info.plist Info.plist
    sed 's/NAME/'$name'/g' Info.plist > Info.plist.bak
    sed 's/PACKAGE/'$packageName'/g' Info.plist.bak > Info.plist
    sed 's/CLASS/'$className'/g' Info.plist > Info.plist.bak
    sed 's/URL/'${site/\/\//\\\/\\\/}'/g' Info.plist.bak > Info.plist
    cp -R ../node-webkit/node-webkit.app node-webkit.app
    cp app.nw node-webkit.app/Contents/Resources/
    cp ../config/mac/app.icns node-webkit.app/Contents/Resources/
    cp Info.plist node-webkit.app/Contents/

    printf 'Package App Success : build/'$name'.app\n'

    rm Info.plist
    rm Info.plist.bak
    mv node-webkit.app $name.app
    mv app.nw $name.nw

    printf 'All Package Success!\n'

    printf 'Open App......\n'
    open -a $name.app
else
    printf 'Can Not Find Node-Webkit App.\n'
    printf 'Please Copy "node-webkit.app" To "node-webkit" Folder.\n'
    if [ ! -x node-webkit ]
    then
        mkdir node-webkit
    fi
fi

