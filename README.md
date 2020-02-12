# deb-package-stats

deb-package-stats is small web application to examine installed packages in Debian based distros. Packages are analyzed from file `/var/lib/dpkg/status`.

# Requirements
- .net Core 3.1 SDK
- docker/docker compose

# Development
- clone this repository
- create and configure self signed certificate for development (see below)
- use either `docker-compose up`, `dotnet run` or your IDE to run the application
    * if the application is run by other means than with docker, all environment variables should be set locally for https
 
## development certificate
In Linux, due to bug in .net cli tooling/openssl, it is necessary to create self-signed certificate(e.g. with [these steps](https://stackoverflow.com/a/59702094)) and then copy the certificate to `src/WebUI/.cert`. It is possible that the certificate should be added to trusted certificates in web browser too. Password for the certificate should be stored to local `ASPNETCORE_Kestrel__Certificates__Default__Password` environment variable which is then passed through docker-compose to the container. All other environment variables are set at `docker-compose.yml`. If the certificate is named differently, the path in `docker-compose.yml` should be changed appropriately.