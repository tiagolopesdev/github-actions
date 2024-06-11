#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

COPY . ./

RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /Arc
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "github-actions.dll"]



# COPY ["github-actions.csproj", "github-actions/"]
# RUN dotnet restore "github-actions/github-actions.csproj"
# COPY . .
# WORKDIR "/src/github-actions"
# RUN dotnet build "github-actions.csproj" -c Release -o /app/build

# FROM build AS publish
# RUN dotnet publish "github-actions.csproj" -c Release -o /app/publish /p:UseAppHost=false

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app/publish .
# ENTRYPOINT ["dotnet", "github-actions.dll"]