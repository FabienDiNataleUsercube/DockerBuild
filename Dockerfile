# escape=`

# Use the Windows Server Core image 1709 with .NET Framework 3.5
FROM mcr.microsoft.com/dotnet/framework/sdk:3.5-windowsservercore-1709

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Download the Build Tools bootstrapper.
ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe

# Install the build tools and the needed tools
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath C:\BuildTools `
    --add Microsoft.VisualStudio.Workload.AzureBuildTools `
    --add Microsoft.VisualStudio.Workload.MSBuildTools `
    --add Microsoft.VisualStudio.Workload.WebBuildTools `
    --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Win81 `
    --add Microsoft.VisualStudio.Component.SQL.SSDTBuildSku `
    --add Microsoft.VisualStudio.Component.VC.140 `
    --add Microsoft.Net.Component.4.6.2.SDK `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 `
    --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 `
 || IF "%ERRORLEVEL%"=="3010" EXIT 0

# Download and install 7-Zip
ADD https://www.7-zip.org/a/7z1900-x64.exe C:\TEMP\7z1900-x64.exe
RUN start /wait C:\TEMP\7z1900-x64.exe /S 

VOLUME c:/response

# Define the entry point for the Docker container to starts the build powershell and leave
ENTRYPOINT ["C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&","powershell.exe", "c:\\source\\LaunchBuild.ps1"]