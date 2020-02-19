FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /app

# Copy sln and csproj files, and restore as distinct layers
COPY *.sln .
COPY src/WebUI/*.csproj ./src/WebUI/
COPY src/Application/*.csproj ./src/Application/
COPY test/WebUI.Test/*.csproj ./test/WebUI.Test/
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet build

FROM build as testrunner
WORKDIR /app/test/WebUI.Test
CMD ["dotnet", "test", "--logger:trx"]

FROM build AS test
WORKDIR /app
RUN dotnet test --logger:trx

FROM build as publish
WORKDIR /app/src/WebUI
RUN dotnet publish -c Release -o out


# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=publish /app/src/WebUI/out ./
CMD ASPNETCORE_URLS=http://*:$PORT dotnet WebUI.dll
# ENTRYPOINT ["dotnet", "WebUI.dll"]