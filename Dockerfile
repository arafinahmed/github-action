#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 9001

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["src/ForDockerTest/ForDockerTest/ForDockerTest.csproj", "ForDockerTest/"]
COPY . .
RUN dotnet restore "ForDockerTest/ForDockerTest.csproj"
COPY . .
WORKDIR "/src/ForDockerTest"
RUN dotnet build "ForDockerTest.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ForDockerTest.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ForDockerTest.dll"]