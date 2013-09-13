Node-Webkit-Packager
====================

完成MacOS上Node-webkit的App自动打包脚本，支持打包`Mac App`和`Win32 App`。

1.Node-webkit项目目录为`resources`;

2.脚本文件`tool/builder.sh`;

3.将Node-Webkit的核心文件放到`node-webkit`目录下，分`mac`和`win`两个目录，`mac`下应有`node-webkit.app`，而`win`下应有`nw.exe`、`nwsnapshot.exe`、`nw.pak`、`icudt.dll`、`ffmpegsumo.dll`、`libEGL.dll`、`libGLESv2`；

4.配置文件`config/app.config`:

    app_name=Demo  //APP的名称
    app_class=demo  //APP的Class
    app_package=me.edwon.nw  //APP的Package
    app_site=http://edwon.sinaapp.com  //APP的官方地址
    app_type=all  //需要打包的类型 all|mac|win

对于`Mac`，需要在`config/mac`下增加`app.icns`和`Info.plist`。

Info.plist代码:

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>CFBundleDevelopmentRegion</key>
        <string>en</string>
        <key>CFBundleDisplayName</key>
        <string>NAME</string>
        <key>CFBundleDocumentTypes</key>
        <array>
            <dict>
                <key>CFBundleTypeIconFile</key>
                <string>app.icns</string>
                <key>CFBundleTypeName</key>
                <string>NAME</string>
                <key>CFBundleTypeRole</key>
                <string>Viewer</string>
                <key>LSHandlerRank</key>
                <string>Owner</string>
                <key>LSItemContentTypes</key>
                <array>
                    <string>PACKAGE.CLASS</string>
                </array>
            </dict>
            <dict>
                <key>CFBundleTypeName</key>
                <string>Folder</string>
                <key>CFBundleTypeOSTypes</key>
                <array>
                    <string>fold</string>
                </array>
                <key>CFBundleTypeRole</key>
                <string>Viewer</string>
                <key>LSHandlerRank</key>
                <string>None</string>
            </dict>
        </array>
        <key>CFBundleExecutable</key>
        <string>node-webkit</string>
        <key>CFBundleIconFile</key>
        <string>app.icns</string>
        <key>CFBundleIdentifier</key>
        <string>PACKAGE</string>
        <key>CFBundleInfoDictionaryVersion</key>
        <string>6.0</string>
        <key>CFBundleName</key>
        <string>NAME</string>
        <key>CFBundlePackageType</key>
        <string>APPL</string>
        <key>CFBundleShortVersionString</key>
        <string>29.0.1547.31</string>
        <key>CFBundleVersion</key>
        <string>1547.31</string>
        <key>LSFileQuarantineEnabled</key>
        <true/>
        <key>LSMinimumSystemVersion</key>
        <string>10.6.0</string>
        <key>NSPrincipalClass</key>
        <string>NSApplication</string>
        <key>NSSupportsAutomaticGraphicsSwitching</key>
        <true/>
        <key>SCMRevision</key>
        <string>213023</string>
        <key>UTExportedTypeDeclarations</key>
        <array>
            <dict>
                <key>UTTypeConformsTo</key>
                <array>
                    <string>com.pkware.zip-archive</string>
                </array>
                <key>UTTypeDescription</key>
                <string>NAME</string>
                <key>UTTypeIconFile</key>
                <string>app.icns</string>
                <key>UTTypeIdentifier</key>
                <string>PACKAGE.CLASS</string>
                <key>UTTypeReferenceURL</key>
                <string>URL</string>
                <key>UTTypeTagSpecification</key>
                <dict>
                    <key>com.apple.ostype</key>
                    <string>node-webkit</string>
                    <key>public.filename-extension</key>
                    <array>
                        <string>nw</string>
                    </array>
                    <key>public.mime-type</key>
                    <string>application/x-node-webkit-app</string>
                </dict>
            </dict>
        </array>
    </dict>
    </plist>

其中`NAME`、`PACKAGE`、`CLASS`、`URL`会根据配置项自动替换。(也可以自定义)

对于`Win32`，前四个配置项无效。





