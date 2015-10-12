$dir = "C:\SourceCode\SyncThing\Binaries"
New-Item -Path $dir -Type Directory

wget "https://github.com/kohsuke/winsw/releases/download/1.17-beta.2/winsw.exe" -OutFile "$dir\syncthingservice.exe"

Copy-Item AUTHORS -destination "$dir\AUTHORS.txt"
Copy-Item LICENSE -destination "$dir\LICENSE.txt"
Copy-Item README.md -destination "$dir\README.txt"

wget http://docs.syncthing.net/pdf/FAQ.pdf -OutFile "$dir\FAQ.pdf"
wget http://docs.syncthing.net/pdf/Getting-Started.pdf -OutFile "$dir\Getting-Started.pdf"

Copy-Item etc\windows\syncthingservice.xml -destination "$dir\syncthingservice.xml"

. nsis "etc\windows\SyncThingSetup.nsi"
