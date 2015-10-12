$ErrorActionPreference = "Stop"

$dir = "C:\SourceCode\SyncThing\Binaries"
New-Item -Path $dir -Type Directory

$nsis_dir = "C:\Program Files (x86)\NSIS"

wget "http://nsis.sourceforge.net/mediawiki/images/c/c9/NSIS_Simple_Service_Plugin_1.30.zip" -OutFile "C:\SourceCode\NSIS_Simple_Service_Plugin_1.30.zip"
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory("C:\SourceCode\NSIS_Simple_Service_Plugin_1.30.zip", "C:\SourceCode")

Copy-Item "C:\SourceCode\SimpleSC.dll" "$nsis_dir\SimpleSC.dll"

wget "https://github.com/kohsuke/winsw/releases/download/1.17-beta.2/winsw.exe" -OutFile "$dir\syncthingservice.exe"

Copy-Item AUTHORS -destination "$dir\AUTHORS.txt"
Copy-Item LICENSE -destination "$dir\LICENSE.txt"
Copy-Item README.md -destination "$dir\README.txt"

wget http://docs.syncthing.net/pdf/FAQ.pdf -OutFile "$dir\FAQ.pdf"
wget http://docs.syncthing.net/pdf/Getting-Started.pdf -OutFile "$dir\Getting-Started.pdf"

Copy-Item etc\windows\syncthingservice.xml -destination "$dir\syncthingservice.xml"
Copy-Item syncthing.exe -destination "$dir\syncthing.exe"

$env:PATH += ";$nsis_dir"

Write-Host "Building Setup with NSIS"
. makensis "etc\windows\SyncThingSetup.nsi"

Write-Host "Contents of $dir"
Dir $dir

Write-Host "Contents of ."
Dir "."

Write-Host "Contents of etc\windows"
Dir "etc\windows"
