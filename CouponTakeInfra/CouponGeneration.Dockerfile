FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /build
COPY CouponTakeInfra.CouponGeneration ./CouponTakeInfra.CouponGeneration/
COPY CouponTakeInfra.Db ./CouponTakeInfra.Db/

WORKDIR /build/CouponTakeInfra.CouponGeneration/
RUN dotnet restore "CouponTakeInfra.CouponGeneration.csproj"
RUN dotnet build "CouponTakeInfra.CouponGeneration.csproj" --no-restore -c Release -o /app/build

WORKDIR /build/CouponTakeInfra.Db/
RUN dotnet restore "CouponTakeInfra.Db.csproj"
RUN dotnet build "CouponTakeInfra.Db.csproj" --no-restore -c Release -o /app/build

FROM build AS publish
WORKDIR /build/CouponTakeInfra.CouponGeneration/
RUN dotnet publish "CouponTakeInfra.CouponGeneration.csproj" -c Release -o /publish

FROM base AS take-publish
COPY --from=publish /publish .

FROM take-publish AS certification
ARG JwtPrivateKeyPath=/certificates/jwt-auth-pub-key.pem

ADD ${JwtPrivateKeyPath} .

ENTRYPOINT ["dotnet", "CouponTakeInfra.CouponGeneration.dll"]