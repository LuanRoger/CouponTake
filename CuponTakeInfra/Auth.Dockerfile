FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /build
COPY CuponTakeInfra.Auth ./CuponTakeInfra.Auth/
COPY CuponTakeInfra.Db ./CuponTakeInfra.Db/

WORKDIR /build/CuponTakeInfra.Auth/
RUN dotnet restore "CuponTakeInfra.Auth.csproj"
RUN dotnet build "CuponTakeInfra.Auth.csproj" --no-restore -c Release -o /app/build

WORKDIR /build/CuponTakeInfra.Db/
RUN dotnet restore "CuponTakeInfra.Db.csproj"
RUN dotnet build "CuponTakeInfra.Db.csproj" --no-restore -c Release -o /app/build

FROM build AS publish
WORKDIR /build/CuponTakeInfra.Auth/
RUN dotnet publish "CuponTakeInfra.Auth.csproj" -c Release -o /publish

FROM base AS take-publish
COPY --from=publish /publish .

FROM take-publish AS certification
ARG JwtPrivateKeyPath=/certificates/jwt-auth-priv-key.pem
ARG JwtPublicKeyPath=/certificates/jwt-auth-pub-key.pem

ADD ${JwtPrivateKeyPath} .
ADD ${JwtPublicKeyPath} .

ENTRYPOINT ["dotnet", "CuponTakeInfra.Auth.dll"]