FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /build
COPY CuponTakeInfra.Gateway ./CuponTakeInfra.Gateway/

WORKDIR /build/CuponTakeInfra.Gateway/
RUN dotnet restore "CuponTakeInfra.Gateway.csproj"
RUN dotnet build "CuponTakeInfra.Gateway.csproj" --no-restore -c Release -o /app/build

FROM build AS publish
WORKDIR /build/CuponTakeInfra.Gateway/
RUN dotnet publish "CuponTakeInfra.Gateway.csproj" -c Release -o /publish

FROM base AS take-publish
COPY --from=publish /publish .

ENTRYPOINT ["dotnet", "CuponTakeInfra.Gateway.dll"]