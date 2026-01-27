FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install Chocolatey
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install Ruby with DevKit via Chocolatey
RUN choco install ruby --version=3.1.6.1 -y --params "'/InstallDir:C:\Ruby31-x64'"
RUN choco install msys2 -y

# Add Ruby to PATH
RUN $env:PATH = 'C:\\Ruby31-x64\\bin;' + $env:PATH; \
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

# Install bundler and required gems
RUN gem install bundler --no-document

# Set working directory
WORKDIR C:\\workspace

# Install ridk (Ruby Installer Development Kit)
RUN ridk install 2 3

CMD ["powershell.exe"]