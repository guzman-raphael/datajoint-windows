# FROM nanoserver/iis-php
# FROM mcr.microsoft.com/powershell:6.2.0-nanoserver-1803
FROM mcr.microsoft.com/powershell:6.2.0-nanoserver-1809

MAINTAINER raphael.h.guzman@gmail.com

# ENV MYSQL_ROOT_PASSWORD simple

ADD https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.22-winx64.zip mysql.zip
# ADD https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.9-winx64.zip mysql.zip

RUN pwsh -NoLogo -NoProfile -Command \
    Expand-Archive -Path c:\mysql.zip -DestinationPath C:\ ; \
    ren C:\mysql-5.7.22-winx64 C:\MySQL ; \
    New-Item -Path C:\MySQL\data -ItemType directory ; \
    # Remove-Item c:\mysql.zip -Force ; \
    C:\MySQL\bin\mysqld.exe --initialize --log_syslog=0 --user=mysql 
    # C:\MySQL\bin\mysqld.exe --initialize --console --explicit_defaults_for_timestamp ; \
    # C:\MySQL\bin\mysqld.exe --install ; \
    # Start-Service mysql ; \
    # Remove-Item c:\mysql.zip -Force

# ADD https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-installer-web-community-5.7.9.0.msi c:/mysql-5.7.9.0.msi

# SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
# RUN Start-Process 'C:\mysql-5.7.9.0.msi' '/qn' -PassThru | Wait-Process;


# SHELL ["cmd", "/C"]


# RUN echo hi
# RUN msiexec /i mysql-5.7.9.0.msi /quiet

    
ENV MYSQL C:\\MySQL
# RUN setx PATH /M %PATH%;C:\MySQL\bin
#1809
ENV PATH="$WindowsPATH;${ProgramFiles}\PowerShell;C:\MySQL\bin"


EXPOSE 3306
# ENTRYPOINT [ "C:/MySQL/bin/mysqld.exe" ]
COPY mysql-init.txt C:/mysql-init.txt
ENTRYPOINT [ "mysqld --init-file=C:\\mysql-init.txt" ]
# CMD [ "--console" , "--skip-name-resolve", "--skip-grant-tables", "--log_syslog=0" ]
