FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /build
COPY CouponTakeInfra.Gateway ./CouponTakeInfra.Gateway/

WORKDIR /build/CouponTakeInfra.Gateway/
RUN dotnet restore "CouponTakeInfra.Gateway.csproj"
RUN dotnet build "CouponTakeInfra.Gateway.csproj" --no-restore -c Release -o /app/build

FROM build AS publish
WORKDIR /build/CouponTakeInfra.Gateway/
RUN dotnet publish "CouponTakeInfra.Gateway.csproj" -c Release -o /publish

FROM base AS take-publish
COPY --from=publish /publish .

ENTRYPOINT ["dotnet", "CouponTakeInfra.Gateway.dll"]