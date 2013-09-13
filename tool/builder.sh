#!/bin/bash

basePath=$(cd "$(dirname "$0")"; pwd)'/..'

printf '===========================================================\n'
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
    elif [ $key = 'app_type' ]
    then
        outputType=$value
    fi
done < $basePath/config/app.config

printf '  APPNAME : '$name'\n'
printf '  APPCLASS : '$packageName'.'$className'\n'
printf '  APPTYPE : '$outputType'\n'
printf '  WEBSITE : '$site'\n'

cd $basePath'/'

if [ -x build ]
then
    rm -r build/
fi
mkdir build/

if [ ! -x node-webkit/ ]
then
    mkdir node-webkit
    mkdir node-webkit/mac
    mkdir node-webkit/win
fi

printf '===========================================================\n'
printf 'Start Package Resources : \n'

if [ -n $1 ]
then
    cd $1
else
    cd $basePath/resources
fi
printf "  Resources Path : "
pwd
zip $basePath/build/$name.nw *
printf 'Package Resources Success : build/'$name'.nw\n'

cd $basePath/build

if [ $outputType='all' -o $outputType='mac' ]
then
    printf '===========================================================\n'
    if [ -x ../node-webkit/mac/node-webkit.app ]
    then
        printf 'Start Package Mac App : \n'
        mv $name.nw app.nw

        cp ../config/mac/Info.plist Info.plist
        sed 's/NAME/'$name'/g' Info.plist > Info.plist.bak
        sed 's/PACKAGE/'$packageName'/g' Info.plist.bak > Info.plist
        sed 's/CLASS/'$className'/g' Info.plist > Info.plist.bak
        sed 's/URL/'${site/\/\//\\\/\\\/}'/g' Info.plist.bak > Info.plist

        cp -R ../node-webkit/mac/node-webkit.app node-webkit.app
        cp app.nw node-webkit.app/Contents/Resources/
        cp ../config/mac/app.icns node-webkit.app/Contents/Resources/
        cp Info.plist node-webkit.app/Contents/

        printf 'Package App Success : build/'$name'.app\n'

        rm Info.plist
        rm Info.plist.bak

        mkdir mac
        mv node-webkit.app mac/$name.app
        mv app.nw $name.nw

    else
        printf 'Can Not Find Node-Webkit App.\n'
        printf 'Please Copy "node-webkit.app" To "node-webkit\mac" Folder.\n'
    fi
fi

if [ $outputType='all' -o $outputType='win' ]
then
    printf '===========================================================\n'
    if [ -f ../node-webkit/win/nw.exe ]
    then
        printf 'Start Package Win32 App : \n'
        cp $name.nw ../node-webkit/win
        cd ../node-webkit/win
        mv $name.nw app.nw
        cat nw.exe app.nw > $name.exe
        pwd

        mkdir ../../build/win
        mv $name.exe ../../build/win
        cp icudt.dll ../../build/win
        cp nw.pak ../../build/win
        rm app.nw
    else
        printf 'Can Not Find Node-Webkit Exe.\n'
        printf 'Please Copy "nw.exe" And Other "dll" To "node-webkit\win" Folder.\n'
    fi
fi

printf '===========================================================\n'
printf 'Process End!\n'

