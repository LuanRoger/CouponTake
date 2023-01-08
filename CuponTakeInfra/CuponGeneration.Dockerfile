FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /build
COPY CuponTakeInfra.CuponGeneration ./CuponTakeInfra.CuponGeneration/
COPY CuponTakeInfra.Db ./CuponTakeInfra.Db/

WORKDIR /build/CuponTakeInfra.CuponGeneration/
RUN dotnet restore "CuponTakeInfra.CuponGeneration.csproj"
RUN dotnet build "CuponTakeInfra.CuponGeneration.csproj" --no-restore -c Release -o /app/build

WORKDIR /build/CuponTakeInfra.Db/
RUN dotnet restore "CuponTakeInfra.Db.csproj"
RUN dotnet build "CuponTakeInfra.Db.csproj" --no-restore -c Release -o /app/build

FROM build AS publish
WORKDIR /build/CuponTakeInfra.CuponGeneration/
RUN dotnet publish "CuponTakeInfra.CuponGeneration.csproj" -c Release -o /publish

FROM base AS take-publish
COPY --from=publish /publish .

FROM take-publish AS certification
ARG JwtPrivateKeyPath=/certificates/jwt-auth-pub-key.pem

ADD ${JwtPrivateKeyPath} .

ENTRYPOINT ["dotnet", "CuponTakeInfra.CuponGeneration.dll"]