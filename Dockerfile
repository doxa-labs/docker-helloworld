FROM mcr.microsoft.com/dotnet/core/runtime:3.0-buster-slim AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY ["Docker.HelloWorld.csproj", ""]
RUN dotnet restore "./Docker.HelloWorld.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "Docker.HelloWorld.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Docker.HelloWorld.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Docker.HelloWorld.dll"]